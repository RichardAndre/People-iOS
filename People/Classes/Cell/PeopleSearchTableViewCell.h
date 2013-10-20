//
//  PeopleSearchTableViewCell.h
//  People
//
//  Created by Bruno Koga on 10/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "HHPanningTableViewCell.h"

@interface PeopleSearchTableViewCell : HHPanningTableViewCell

@property (nonatomic, strong) UIViewController *viewController;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

//Drawer
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UIButton *mobileButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *smsButton;


+ (UINib *)nib;

@end
