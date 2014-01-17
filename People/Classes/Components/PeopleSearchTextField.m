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
    [self adjustSearchIconForStringLength:self.text.length];

}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self adjustSearchIconForStringLength:text.length];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self adjustSearchIconForStringLength:attributedText.length];
}

- (void)adjustSearchIconForStringLength:(NSInteger)stringLength
{
    UIImageView *leftView = (UIImageView *)self.leftView;
    UIImage *image = stringLength > 0 ? [UIImage imageNamed:@"LupaBranca"] : [UIImage imageNamed:@"iconeLupaVerde"];
    leftView.image = image;
}

@end
