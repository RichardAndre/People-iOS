//
//  PeopleTheme.m
//  People
//
//  Created by Bruno Koga on 10/15/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleThemeManager.h"
#import "PeopleBasicTheme.h"

@interface PeopleThemeManager ()

@property (nonatomic, strong) id<PeopleTheme> theme;
@end

@implementation PeopleThemeManager

+ (PeopleThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static PeopleThemeManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.theme = [PeopleBasicTheme new];
    });
    return sharedInstance;
}

+ (id<PeopleTheme>)theme
{
    return [self sharedInstance].theme;
}



@end
