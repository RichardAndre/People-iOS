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
    return [UIColor colorWithRed:22.0f / 255.0f
                           green:28.0f / 255.0f
                            blue:35.0f / 255.0f
                           alpha:1.0];
}


- (UIColor *)primaryColorLight
{
    return [UIColor colorWithRed:17.0f / 255.0f
                           green:115.0f / 255.0f
                            blue:237.0f / 255.0f
                           alpha:1.0f];
    
}

- (UIColor *)primaryColorDark
{
    return [UIColor colorWithRed:0.0f / 255.0f
                           green:90.0f / 255.0f
                            blue:201.0f / 255.0f
                           alpha:1.0f];
    
}

- (UIColor *)secondaryColorDark
{
    return [UIColor colorWithRed:22.0f / 255.0f
                           green:73.0f / 255.0f
                            blue:131.0f / 255.0f
                           alpha:1.0f];
}

- (UIColor *)thirdColorDark
{
    return [UIColor colorWithRed:217.0f / 255.0f
                           green:220.0f / 255.0f
                            blue:223.0f / 255.0f
                           alpha:1.0f];
}

- (UIColor *)thirdColorLight
{
    return [UIColor colorWithRed:242.0f / 255.0f
                           green:245.0f / 255.0f
                            blue:247.0f / 255.0f
                           alpha:1.0f];
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
