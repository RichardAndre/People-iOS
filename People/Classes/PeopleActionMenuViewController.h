//
//  PeopleActionMenuViewController.h
//  People
//
//  Created by Christian Sampaio on 12/16/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleNavigationViewController.h"

@interface PeopleActionMenuViewController : UIViewController

@property (assign, nonatomic) PeopleNavigationViewController *navigation;

- (void)populateMenu;
- (void)changeHasPeople;

@end
