//
//  PeopleCollaborator+PopulateFromServiceResponse.m
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleCollaborator+PopulateFromServiceResponse.h"
#import <ARSafeJSON/ARSafeJSON.h>
#import "NSString+PhoneNumberFormatter.h"

@implementation PeopleCollaborator (PopulateFromServiceResponse)

+ (NSArray *)collaboratorsFromSearchResponse:(NSArray *)responseArray;
{
    NSMutableArray *collaboratoresArray = [NSMutableArray array];
    for (NSArray *collaboratorArray in responseArray)
    {
        PeopleCollaborator *collaborator = [[PeopleCollaborator alloc] init];
        
        collaborator.name = collaboratorArray[0];
        collaborator.login = collaboratorArray[1];
        collaborator.phone = @([[collaboratorArray[2] phoneNumberFormat] longLongValue]);
        collaborator.mobile = @([[collaboratorArray[3] phoneNumberFormat] longLongValue]);
        collaborator.role = collaboratorArray[4];
        collaborator.mentorLogin = collaboratorArray[5];
        collaborator.managerLogin = collaboratorArray[6];
        collaborator.location = collaboratorArray[7];
        
        [collaboratoresArray addObject:collaborator];
    }
    
    return [NSArray arrayWithArray:collaboratoresArray];
}

+ (instancetype)collaboratorFromProfileResponse:(NSDictionary *)dirtyResponseDictionary
{
    //removing empty strings and [NSNull null] values
    ARSafeJSON *safeJSON = [[ARSafeJSON alloc] init];
    NSDictionary *responseDictionary = [safeJSON cleanUpJson:dirtyResponseDictionary];
    
    PeopleCollaborator *collaborator = [[PeopleCollaborator alloc] init];

    NSDictionary *collaboratorDictionary = responseDictionary[@"personal_info"];
    
    collaborator.birthday = collaboratorDictionary[@"birthday"];
    collaborator.building = collaboratorDictionary[@"building"];
    collaborator.email = collaboratorDictionary[@"email"];
    collaborator.joiningDate = collaboratorDictionary[@"joining_date"];
    collaborator.location = collaboratorDictionary[@"location"];
    collaborator.login = collaboratorDictionary[@"login"];
    collaborator.mobile = collaboratorDictionary[@"mobile"];
    collaborator.name = collaboratorDictionary[@"name"];
    collaborator.ownWords = collaboratorDictionary[@"own_words"];
    collaborator.phone = collaboratorDictionary[@"phone"];
    collaborator.role = collaboratorDictionary[@"role"];
    collaborator.managerLogin = collaboratorDictionary[@"manager_login"];
    collaborator.managerName = collaboratorDictionary[@"manager"];
    collaborator.mentorName = collaboratorDictionary[@"mentor"];
    collaborator.mentorLogin = collaboratorDictionary[@"mentor_login"];
    collaborator.skills = responseDictionary[@"skills"];
    
    NSDictionary *projectsDictionary = responseDictionary[@"projects"];
    collaborator.currentProjects = projectsDictionary[@"current"];
    collaborator.pastProjects = projectsDictionary[@"past"];

    if ([responseDictionary[@"teammates"] isKindOfClass:[NSDictionary class]]) {
        collaborator.teammates = [NSSet setWithArray:[responseDictionary[@"teammates"] allValues]];
    } else {
        collaborator.teammates = [NSSet set];
    }
    
    NSArray *socialNetworksArray = [responseDictionary[@"employee_sociallinks"] allObjects];
    NSMutableDictionary *socialNetworks = [NSMutableDictionary dictionary];
    for (NSDictionary *socialNetwork in socialNetworksArray)
    {
        NSString *socialNetworkName = socialNetwork[@"name"];
        NSString *socialNetworkLink = socialNetwork[@"link"];
        NSString *socialNetworkLogo = socialNetwork[@"logo"];
        
        [socialNetworks setObject:@{@"link" : socialNetworkLink,
                                    @"logo" : socialNetworkLogo}
                           forKey:socialNetworkName];
    }
    collaborator.socialNetworks = [NSDictionary dictionaryWithDictionary:socialNetworks];
    
    return collaborator;
    
}

@end
