//
//  UserModelManager.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataService.h"
#import "User+CoreDataProperties.h"
#import "UserModel.h"
#import "DatabaseManager.h"


@interface CoreDataManager : NSObject <DatabaseManagerProtocol>

#pragma Mark - Propertyes
@property (strong, nonatomic) CoreDataService            *CoreDataService;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

//#pragma Mark - Class Methods
//+ (instancetype)defaultManager;
//
//#pragma mark - Public Properties
//- (void)addUser:(NSDictionary *)userDict;
//- (RLMResults *)fetchResultWithPredicate:(NSPredicate *)predicate;
//- (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate;

@end
