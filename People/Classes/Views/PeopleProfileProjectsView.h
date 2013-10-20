//
//  PeopleProfileProjectsView.h
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleProfileProjectsView : UIView

@property (nonatomic, strong) NSArray *pastProjects;
@property (nonatomic, strong) NSArray *currentProjects;

//it's prefered to use this instead of properties
- (void)setPastProjects:(NSArray *)pastProjects currentProjects:(NSArray *)currentProjects;

- (CGFloat)totalHeight;

@end
