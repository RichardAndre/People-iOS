//
//  PeopleSearchDataSource.h
//  People
//
//  Created by Bruno Koga on 10/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface PeopleSearchDataSource : NSObject <UITableViewDataSource>
@property (strong, nonatomic) NSArray *items;

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
          configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
