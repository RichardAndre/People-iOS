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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
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

- (UIImage *) screenshot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
