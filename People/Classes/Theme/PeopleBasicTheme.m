//
//  PeopleBasicTheme.m
//  People
//
//  Created by Bruno Koga on 10/15/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBasicTheme.h"

@implementation PeopleBasicTheme

static NSString * const kPeopleBasicThemeNumberRegularFont = @"Roboto-Regular";
static NSString * const kPeopleBasicThemeNumberLightFont = @"Roboto-Light";
static NSString * const kPeopleBasicThemeNumberMediumFont = @"Roboto-Medium";
static NSString * const kPeopleBasicThemeLightFont = @"Raleway-Light";
static NSString * const kPeopleBasicThemeRegularFont = @"Raleway";
static NSString * const kPeopleBasicThemeMediumFont = @"Raleway-Medium";


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

- (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeMediumFont
                           size:size];
    
}

- (UIFont *)regularNumberFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeNumberRegularFont
                           size:size];
}

- (UIFont *)lightNumberFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeNumberLightFont
                           size:size];
    
}

- (UIFont *)mediumNumberFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kPeopleBasicThemeNumberMediumFont
                           size:size];
    
}

- (UIColor *)darkColor
{
    return [UIColor colorWithRed:22.0f / 255.0f
                           green:28.0f / 255.0f
                            blue:35.0f / 255.0f
                           alpha:1.0];
}

/*
 * Light Green
 */
- (UIColor *)primaryColorLight
{
    return [UIColor colorWithRed:127.0f / 255.0f
                           green:206.0f / 255.0f
                            blue:214.0f / 255.0f
                           alpha:1.0f];
    
}

/*
 * Gray
 */
- (UIColor *)primaryColorMenu
{
    return [UIColor colorWithRed:55.0f / 255.0f
                           green:55.0f / 255.0f
                            blue:55.0f / 255.0f
                           alpha:1.0f];
    
}

/*
 * Green
 */
- (UIColor *)primaryColorDark
{
    return [UIColor colorWithRed:32.0f / 255.0f
                           green:190.0f / 255.0f
                            blue:198.0f / 255.0f
                           alpha:1.0f];
    
}

/*
 * Dark Green
 */
- (UIColor *)secondaryColorDark
{
    return [UIColor colorWithRed:33.0f / 255.0f
                           green:183.0f / 255.0f
                            blue:191.0f / 255.0f
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
