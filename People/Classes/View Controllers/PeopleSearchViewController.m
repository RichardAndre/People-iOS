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

@interface PeopleSearchViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) PeopleSearchDataSource *datasource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation PeopleSearchViewController

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
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


- (void)setupTableView
{
    
    TableViewCellConfigureBlock configureCell = ^(PeopleSearchTableViewCell *cell, PeopleCollaborator *collaborator) {
        [cell configureForCollaborator:collaborator];

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

#pragma mark - Search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [PeopleServices colaboradoresForSearchTerm:self.searchTextField.text
                                       success:^(NSArray *colaboradores) {
                                           self.datasource.items = [colaboradores copy];
                                           
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
