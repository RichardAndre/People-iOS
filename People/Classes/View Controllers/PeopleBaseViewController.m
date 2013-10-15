//
//  PeopleBaseViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBaseViewController.h"

@interface PeopleBaseViewController ()

@end

@implementation PeopleBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adjustFonts];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial Adjusts

- (void)adjustFonts
{
    //must be overriden
}
@end
