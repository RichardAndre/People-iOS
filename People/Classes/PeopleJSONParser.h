//
//  PeopleJSONParse.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleCollaborator+PopulateFromServiceResponse.h"

@interface PeopleJSONParser : NSObject

- (NSArray *)collaboratorsFromSearchResponse:(id)serviceResponse;
- (PeopleCollaborator *)collaboratorFromProfileResponse:(id)serviceResponse;

@end
