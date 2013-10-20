//
//  PeopleProfileViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileViewController.h"

@interface PeopleProfileViewController ()

@end

@implementation PeopleProfileViewController

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
    [self populate];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)populate
{
    //FIXME: remove hardcoded stuff
    //    [self.scrollView setContentSize:CGSizeMake(320.0, 900.0)];
}

- (void)setCollaborator:(PeopleCollaborator *)collaborator
{
    _collaborator = collaborator;
    self.title = collaborator.login;
}

@end
