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
#import "PeopleThemeManager.h"

@interface PeopleSearchViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
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
    [self.searchView setBackgroundColor:[theme primaryColorLight]];
    [self.searchTextField setBackgroundColor:[theme primaryColorDark]];
    [self.searchTextField setTextColor:[theme secondaryColor]];
}

- (void)adjustFonts
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.searchTextField setFont:[theme lightFontWithSize:self.searchTextField.font.pointSize]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.selectedIndexPath)
    {
        [self.resultsTableView deselectRowAtIndexPath:self.selectedIndexPath
                                             animated:YES];
        self.selectedIndexPath = nil;
    }
}

- (void)bounceSearchView
{
    CGRect oldFrame = self.searchView.frame;
    [self.searchView setFrame:CGRectMake(oldFrame.origin.x,
                                         oldFrame.origin.y - oldFrame.size.height,
                                         oldFrame.size.width,
                                         oldFrame.size.height)];
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:25.0 options:0 animations:^{
        
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
                                     cell.photoImageView.image = image;
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


@end
