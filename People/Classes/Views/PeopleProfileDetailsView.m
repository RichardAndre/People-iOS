//
//  PeopleProfileDetailsView.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileDetailsView.h"
#import "PeopleThemeManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation PeopleProfileDetailsView

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
    self.locationLabel.layer.cornerRadius = 10.0;
    [self adjustFonts];
}

- (void)adjustFonts
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.nameLabel setFont:[theme regularFontWithSize:self.nameLabel.font.pointSize]];
    [self.roleLabel setFont:[theme regularFontWithSize:self.roleLabel.font.pointSize]];
    [self.locationLabel setFont:[theme regularFontWithSize:self.locationLabel.font.pointSize]];
}

@end
