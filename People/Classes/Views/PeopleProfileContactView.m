//
//  PeopleProfileContactView.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileContactView.h"

@implementation PeopleProfileContactView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.button1 setTitle:@"" forState:UIControlStateNormal];
    [self.button2 setTitle:@"" forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
