//
//  PeopleProfileCoachView.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileCoachView.h"
#import "PeopleThemeManager.h"

@implementation PeopleProfileCoachView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [self adjustFonts];
    [self adjustColors];
}

- (void)adjustColors
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    self.titleLabel.textColor = [theme lightGrayColor];
    
}

- (void)adjustFonts
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.titleLabel setFont:[theme regularFontWithSize:self.titleLabel.font.pointSize]];
    [self.nameButton.titleLabel setFont:[theme regularFontWithSize:self.nameButton.titleLabel.font.pointSize]];
    
}

@end
