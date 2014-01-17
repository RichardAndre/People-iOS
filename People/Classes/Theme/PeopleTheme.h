//
//  PeopleTheme.h
//  People
//
//  Created by Bruno Koga on 10/15/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeopleTheme <NSObject>

- (UIFont *)regularFontWithSize:(CGFloat)size;
- (UIFont *)lightFontWithSize:(CGFloat)size;
- (UIFont *)mediumFontWithSize:(CGFloat)size;
- (UIFont *)lightNumberFontWithSize:(CGFloat)size;
- (UIFont *)regularNumberFontWithSize:(CGFloat)size;
- (UIFont *)mediumNumberFontWithSize:(CGFloat)size;


- (UIColor *)primaryColorLight;
- (UIColor *)primaryColorMenu;
- (UIColor *)primaryColorDark;
- (UIColor *)secondaryColorDark;
- (UIColor *)secondaryColor;
- (UIColor *)thirdColorDark;
- (UIColor *)thirdColorLight;
- (UIColor *)darkColor;
- (UIColor *)lightGrayColor;



@end
