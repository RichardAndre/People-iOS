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
#import "PeopleSearchTableViewCell.h"

@interface PeopleSearchViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) PeopleSearchDataSource *datasource;

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


- (void)setupTableView
{
    /*
    TableViewCellConfigureBlock configureCell = ^(PhotoCell *cell, Photo *photo) {
        [cell configureForPhoto:photo];
    };
  */

    self.datasource = [[PeopleSearchDataSource alloc] initWithCellIdentifier:kPeopleSearchCellIdentifier
                                                          configureCellBlock:nil];
    self.resultsTableView.dataSource = self.datasource;
    self.resultsTableView.delegate = self;

    [self.resultsTableView registerNib:[PeopleSearchTableViewCell nib] forCellReuseIdentifier:kPeopleSearchCellIdentifier];
//    [self.resultsTableView registerClass:[PeopleSearchTableViewCell class]
//                  forCellReuseIdentifier:kPeopleSearchCellIdentifier];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark TableView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}

static NSString * const kSearchToProfileSegue = @"PeopleSearchToProfileSegue";

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
