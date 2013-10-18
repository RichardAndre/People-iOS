//
//  PeopleSearchTableViewCell.m
//  People
//
//  Created by Bruno Koga on 10/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewCell.h"

@interface PeopleSearchTableViewCell ()

@end
@implementation PeopleSearchTableViewCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    [self setupDrawer];
}

- (void)setupDrawer
{
    UIView *drawerView = [[UIView alloc] initWithFrame:self.frame];
    
    drawerView.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    self.drawerView = drawerView;
    self.directionMask = 1;

}

@end
