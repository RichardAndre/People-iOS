//
//  PeopleCollaborator.h
//  People
//
//  Created by Christian Sampaio on 10/14/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleCollaborator : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *mentorLogin;
@property (nonatomic, strong) NSString *mentorName;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *managerName;
@property (nonatomic, strong) NSString *managerLogin;
@property (nonatomic, strong) NSNumber *phone;
@property (nonatomic, strong) NSNumber *mobile;
@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSString *ownWords;
@property (nonatomic, strong) NSDictionary *skills;
@property (nonatomic, strong) NSSet *teammates;
@property (nonatomic, strong) NSDictionary *currentProjects;
@property (nonatomic, strong) NSDictionary *pastProjects;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *joiningDate;
@property (nonatomic, strong) NSDictionary *socialNetworks;

@property (nonatomic, readonly) NSArray *currentProjectsNames;
@property (nonatomic, readonly) NSArray *pastProjectsNames;

@end
