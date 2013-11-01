//
//  PeopleBasicTheme.m
//  People
//
//  Created by Bruno Koga on 10/15/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBasicTheme.h"

@implementation PeopleBasicTheme

static NSString * const kPeopleBasicThemeRegularFont = @"Roboto-Regular";
static NSString * const kPeopleBasicThemeLightFont = @"Roboto-Light";


- (UIFont *)regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeRegularFont
                           size:size];
}

- (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeLightFont
                              size:size];
    
}

- (UIColor *)darkColor
{
    return [UIColor colorWithRed:22.0/255.0
                           green:28.0/255.0
                            blue:35.0/255.0
                           alpha:1.0];
}


- (UIColor *)primaryColorLight
{
    return [UIColor colorWithRed:49.0/255.0
                           green:117.0/255.0
                            blue:210.0/255.0
                           alpha:1.0];
    
}

- (UIColor *)primaryColorDark
{
    return [UIColor colorWithRed:41.0/255.0
                           green:106.0/255.0
                            blue:197.0/255.0
                           alpha:1.0];
    
}

- (UIColor *)secondaryColor
{
    return [UIColor whiteColor];
}

- (UIColor *)lightGrayColor
{
    return [UIColor lightGrayColor];
}

@end
