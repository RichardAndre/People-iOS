//
//  PeopleSearchViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchViewController.h"
#import "PeopleServices.h"
#import "PeopleSearchDataSource.h"
#import "PeopleSearchTableViewCell+ConfigureForCollaborator.h"
#import "PeopleProfileViewController.h"
#import "PeopleSearchTextField.h"
#import "PeopleThemeManager.h"
#import <AMBlurView.h>

@interface PeopleSearchViewController () <UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet PeopleSearchTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) PeopleSearchDataSource *datasource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation PeopleSearchViewController

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self bounceSearchView];
    // Do any additional setup after loading the view from its nib.
}

- (void)adjustUIElements
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.searchView setBackgroundColor:[theme primaryColorDark]];
    [self.searchTextField setBackgroundColor:[theme primaryColorLight]];
    self.searchTextField.delegate = self;
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:@{ NSForegroundColorAttributeName : [theme secondaryColorDark], NSFontAttributeName : [theme mediumFontWithSize:15.0f]}];
    
    [self.searchTextField setFont:[theme mediumFontWithSize:15.0f]];
    [self.searchTextField setAttributedPlaceholder:placeholder];
    [self.searchTextField setTextColor:[theme secondaryColor]];
}

- (void)adjustFonts
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.searchTextField setFont:[theme mediumFontWithSize:self.searchTextField.font.pointSize]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.selectedIndexPath)
    {
        [self.resultsTableView deselectRowAtIndexPath:self.selectedIndexPath
                                             animated:NO];
        self.selectedIndexPath = nil;
    }
}

-(BOOL)prefersStatusBarHidden{
    return self.statusBarHidden;
}

- (void)bounceSearchView
{
    CGRect oldFrame = self.searchView.frame;
    [self.searchView setFrame:CGRectMake(oldFrame.origin.x,
                                         oldFrame.origin.y - oldFrame.size.height,
                                         oldFrame.size.width,
                                         oldFrame.size.height)];

    CGRect textFrame = self.searchTextField.frame;
    CGRect oldTextFrame = self.searchTextField.frame;
    textFrame.origin.y -= 120.f;
    self.searchTextField.frame = textFrame;

    [UIView animateWithDuration:1.0f
                          delay:0.5f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.1f
                        options:kNilOptions
                     animations:^{
                         self.searchTextField.frame = oldTextFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1.0f
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:25.0
                        options:0
                     animations:^{
        
        [self.searchView setFrame:oldFrame];
    } completion:^(BOOL finished) {
        [[self searchTextField] becomeFirstResponder];
    }];
}

- (void)setupTableView
{
    
    TableViewCellConfigureBlock configureCell = ^(PeopleSearchTableViewCell *cell, PeopleCollaborator *collaborator) {
        [cell configureForCollaborator:collaborator];
        cell.viewController = self;

        [PeopleServices photoForUser:collaborator.login
                             success:^(UIImage *image) {
                                 if ([cell.loginLabel.text isEqualToString:collaborator.login]) {
                                     cell.photoImageView.alpha = 0.0f;
                                     cell.photoImageView.image = image;
                                     [UIView animateWithDuration:0.15f animations:^{
                                         cell.photoImageView.alpha = 1.0f;
                                     }];
                                 }
                             }
                             failure:^(NSError *error) {
                                 
                             }];
    };

    self.datasource = [[PeopleSearchDataSource alloc] initWithCellIdentifier:kPeopleSearchCellIdentifier
                                                          configureCellBlock:configureCell];
    self.resultsTableView.dataSource = self.datasource;
    self.resultsTableView.delegate = self;

    [self.resultsTableView registerNib:[PeopleSearchTableViewCell nib] forCellReuseIdentifier:kPeopleSearchCellIdentifier];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark TableView Delegate

static NSString * const kSearchToProfileSegue = @"PeopleSearchToProfileSegue";

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:kSearchToProfileSegue sender:self];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSearchToProfileSegue])
    {
        PeopleProfileViewController *profileViewController = segue.destinationViewController;
        profileViewController.collaborator = self.datasource.items[self.selectedIndexPath.row];
    }
}


#pragma mark - Search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [PeopleServices colaboradoresForSearchTerm:self.searchTextField.text
                                       success:^(NSArray *colaboradores) {
                                           self.datasource.items = [colaboradores copy];
                                           if ([colaboradores count] > 0)
                                           {
                                               self.resultsTableView.hidden = NO;
                                           }
                                           else
                                           {
                                               self.resultsTableView.hidden = YES;
                                           }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self.resultsTableView reloadData];
                                           });
                                           
                                       } failure:^(NSError *error) {
                                           //handle error
                                       }];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *updatedString = [self.searchTextField.text stringByReplacingCharactersInRange:range withString:string];
    [self.searchTextField adjustSearchIconForStringLength:updatedString.length];
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 320.0, 22.0);
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    AMBlurView *blurView = [AMBlurView new];
    blurView.frame = frame;
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:blurView];
    
    UILabel *resultsLabel = [[UILabel alloc] initWithFrame:frame];
    [resultsLabel setTextAlignment:NSTextAlignmentCenter];
    [resultsLabel setFont:[[PeopleThemeManager theme] regularFontWithSize:12.0]];
    [resultsLabel setMinimumScaleFactor:0];
  
    NSUInteger total = [self.resultsTableView.dataSource tableView:self.resultsTableView numberOfRowsInSection:0];
    NSString *result = total <= 1? NSLocalizedString(@"result", "Result header in Search View") : NSLocalizedString(@"results", "Results header in Search View");
    NSString *resultsString = [NSString stringWithFormat:@"%d %@", total, result];
    
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    
    NSMutableAttributedString *attributedHeader = [[NSMutableAttributedString alloc] initWithString:resultsString];
    NSRange numberRange = [resultsString rangeOfString:[NSString stringWithFormat:@"%d", total]];
    NSRange restRange = [resultsString rangeOfString:result];
    [attributedHeader addAttribute:NSFontAttributeName value:[theme mediumNumberFontWithSize:12.0f] range:numberRange];
    [attributedHeader addAttribute:NSFontAttributeName value:[theme regularFontWithSize:12.0f] range:restRange];
    
    resultsLabel.attributedText = [attributedHeader copy];
    
    [headerView addSubview:resultsLabel];
    return headerView;
}


@end
