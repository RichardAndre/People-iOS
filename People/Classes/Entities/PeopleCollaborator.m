//
//  PeopleCollaborator.m
//  People
//
//  Created by Christian Sampaio on 10/14/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleCollaborator.h"

@implementation PeopleCollaborator

- (NSArray *)currentProjectsNames
{
    if ([self.currentProjects count] > 0)
    {
        return [self.currentProjects allKeys];
    }
    return @[];
}

- (NSArray *)pastProjectsNames
{
    if ([self.pastProjects count] > 0)
    {
        return [self.pastProjects allKeys];
    }
    return @[];
    
}

- (NSString *)description
{
    return self.login;
}

@end
