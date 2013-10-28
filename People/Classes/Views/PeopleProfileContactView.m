//
//  PeopleProfileContactView.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileContactView.h"
#import "PeopleThemeManager.h"

@implementation PeopleProfileContactView

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
    [self.button1 setTitle:@"" forState:UIControlStateNormal];
    [self.button2 setTitle:@"" forState:UIControlStateNormal];
}

- (void)adjustFonts
{
    
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.titleLabel setFont:[theme regularFontWithSize:self.titleLabel.font.pointSize]];
    [self.contentLabel setFont:[theme regularFontWithSize:self.contentLabel.font.pointSize]];
}

- (void)configureForPhone
{
    [self.button1 setImage:[UIImage imageNamed:@"iconeSwipePhone"] forState:UIControlStateNormal];
    [self.button2 setHidden:YES];
}

- (void)configureForMobile
{
    [self.button1 setImage:[UIImage imageNamed:@"iconeSwipeMobile"] forState:UIControlStateNormal];
    [self.button2 setImage:[UIImage imageNamed:@"iconeSwipeSMS"] forState:UIControlStateNormal];
    
}

- (void)configureForEmail
{
    [self.button1 setImage:[UIImage imageNamed:@"iconeSwipeEmail"] forState:UIControlStateNormal];
    [self.button2 setHidden:YES];
    
}

@end
