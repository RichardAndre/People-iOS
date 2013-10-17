//
//  PeopleSearchTextField.m
//  People
//
//  Created by Bruno Koga on 10/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation PeopleSearchTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    UIImage *image = [UIImage imageNamed:@"iconeLupa"];
    UIImageView *leftView = [[UIImageView alloc] initWithImage:image];
    leftView.frame = CGRectMake(CGRectGetMinX(leftView.frame),
                                CGRectGetMinY(leftView.frame),
                                34.0,
                                CGRectGetHeight(leftView.frame));
    
    [leftView setContentMode:UIViewContentModeCenter];
                                
    [self setLeftView:leftView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    
    self.layer.cornerRadius = 16.0;

}


@end
