//
//  PeopleLoginToSearchSegue.m
//  People
//
//  Created by Bruno Koga on 10/14/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleLoginToSearchSegue.h"

@implementation PeopleLoginToSearchSegue

- (void)perform
{
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    [source.navigationController pushViewController:destination
                                           animated:YES];
    
    
}

@end
