//
//  PeopleProfileTeamView.h
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleOpenProfileProtocol.h"

@interface PeopleProfileTeamView : UIView
@property (weak, nonatomic) IBOutlet UIButton *viewAllButton;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;

@property (nonatomic, strong) NSArray *teamMembers;
@property (weak) id<PeopleOpenProfileProtocol>delegate;

- (NSInteger)maxCount;
- (void)setTeamMemberPicture:(UIImage *)image forIndex:(NSInteger)index;
@end
