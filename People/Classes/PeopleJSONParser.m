//
//  PeopleJSONParse.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleJSONParser.h"

@implementation PeopleJSONParser

- (NSArray *)collaboratorsFromSearchResponse:(id)serviceResponse;
{
    NSDictionary *responseDictionary = serviceResponse;
    
    NSArray *responseData = [responseDictionary objectForKey:@"data"];
    NSArray *colaboradores = @[];
    if ([responseData isKindOfClass:[NSArray class]])
    {
        colaboradores = [PeopleCollaborator collaboratorsFromSearchResponse:responseData];
    }
    return colaboradores;
}

- (PeopleCollaborator *)collaboratorFromProfileResponse:(id)serviceResponse;
{
    PeopleCollaborator *colaborador = [PeopleCollaborator collaboratorFromProfileResponse:serviceResponse];
    return colaborador;
}



@end
