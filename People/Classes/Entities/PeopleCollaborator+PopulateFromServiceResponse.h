//
//  PeopleColaborador+PopulateFromServiceResponse.h
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleCollaborator.h"

@interface PeopleCollaborator (PopulateFromServiceResponse)

+ (NSArray *)collaboratorsFromSearchResponse:(NSArray *)responseArray;
+ (instancetype)collaboratorFromProfileResponse:(NSDictionary *)responseDictionary;

@end
