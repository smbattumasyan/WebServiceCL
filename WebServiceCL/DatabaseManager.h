//
//  DatabaseManager.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 31.01.17.
//  Copyright © 2017 EGS. All rights reserved.
//

#ifndef DatabaseManager_h
#define DatabaseManager_h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Realm/Realm.h>

#endif /* DatabaseManager_h */

@protocol DatabaseManagerProtocol <NSObject>

@optional
+ (instancetype)defaultManager;
   @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (void)addUser:(NSDictionary *)userDict;
- (RLMResults *)fetchResultWithPredicate:(NSPredicate *)predicate;
- (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate;

@end
