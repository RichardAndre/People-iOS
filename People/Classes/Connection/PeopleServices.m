//
//  PeopleSearchProvider.m
//  People
//
//  Created by Bruno Koga on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleServices.h"
#import "PeopleHTTPSessionManager.h"
#import "PeopleJSONParser.h"

@implementation PeopleServices

+ (void)colaboradoresForSearchTerm:(NSString *)searchTerm
                           success:(void(^)(NSArray *colaboradores))success
                           failure:(void(^)(NSError *error))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    
    [session searchTerm:searchTerm
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                    NSArray *colaboradores = [jsonParser collaboratorsFromSearchResponse:responseObject];
                    success(colaboradores);
                    
                } failure:^(NSError *error) {
                    failure(error);
                    // 1 - offline
                }];
}

+ (void)colaboradorProfileForLogin:(NSString *)login
                           success:(void(^)(PeopleCollaborator *colaborador))success
                           failure:(void(^)(NSError *error))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];

    [session profileForUser:login
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                        PeopleCollaborator *colaborador = [jsonParser collaboratorFromProfileResponse:responseObject];
                        success(colaborador);
                        
                    } failure:^(NSError *error) {
                        failure(error);
                        // 1 - offline
                    }];
}

+ (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
                  success:(void(^)(PeopleCollaborator *colaborador))success
                  failure:(void(^)(NSError *error))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session loginWithUsername:user
                      password:password
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                           PeopleCollaborator *colaborador = [jsonParser collaboratorFromProfileResponse:responseObject];
                           
                           //if there is no colaboradores or more than 1, something went wrong
                           if (colaborador)
                           {
                               success(colaborador);
                           }
                           else
                           {
                               NSError *error = [NSError errorWithDomain:@"com.ciant.people.login" code:0 userInfo:nil];
                               failure(error);
                           }
                           
                       } failure:^(NSError *error) {
                           failure(error);
                       }];
}

+ (void)photoForUser:(NSString *)user
             success:(void(^)(UIImage *image))success
             failure:(void(^)(NSError *error))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session photoForUser:user
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      UIImage *responseImage = (UIImage *)responseObject;
                      success(responseImage);
                  } failure:^(NSError *error) {
                      failure(error);
                  }];
}

+ (void)profileForUser:(NSString *)user
               success:(void (^)(PeopleCollaborator *))success
               failure:(void (^)(NSError *))failure
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session profileForUser:user
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        PeopleJSONParser *jsonParser = [[PeopleJSONParser alloc] init];
                        PeopleCollaborator *colaboradorProfile = [jsonParser collaboratorFromProfileResponse:responseObject];
                        success(colaboradorProfile);
                        
                    } failure:failure];
}

+ (void)setUsername:(NSString *)username
           password:(NSString *)password
{
    PeopleHTTPSessionManager *session = [PeopleHTTPSessionManager sharedManager];
    [session setUsername:username
                password:password];
}




@end
