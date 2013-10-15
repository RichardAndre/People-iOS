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
    [self adjustUIElements];
    [self adjustFonts];
    [self adjustLocalizationItems];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial Adjusts

//TODO: comment
- (void)adjustFonts
{
    //should be overriden
}

//TODO: comment
- (void)adjustUIElements
{
    //should be overriden
}

//TODO: comment
- (void)adjustLocalizationItems
{
    
}

@end
