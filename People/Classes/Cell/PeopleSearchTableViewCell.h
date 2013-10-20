//
//  PeopleSearchTableViewCell.h
//  People
//
//  Created by Bruno Koga on 10/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "HHPanningTableViewCell.h"

@interface PeopleSearchTableViewCell : HHPanningTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

+ (UINib *)nib;

- (void)setImage:(UIImage *)image;

@end
