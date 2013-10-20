//
//  PeopleSearchTableViewCell+ConfigureForCollaborator.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewCell+ConfigureForCollaborator.h"

@implementation PeopleSearchTableViewCell (ConfigureForCollaborator)

- (void)configureForCollaborator:(PeopleCollaborator *)collaborator
{
    self.nameLabel.text = collaborator.name;
    self.loginLabel.text = collaborator.login;
    self.roleLabel.text = collaborator.role;
    self.telLabel.text = [collaborator.phone stringValue];
    self.mobileLabel.text = [collaborator.mobile stringValue];
    self.imageView.image = nil;
}

@end
