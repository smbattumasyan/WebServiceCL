//
//  UserModelManager.m
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager 

//------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//------------------------------------------------------------------------------------------

+ (instancetype)defaultManager {
    static CoreDataManager *defaultManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.CoreDataService = [CoreDataService defaultManager];
    }
    return self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - Public Methods
//-------------------------------------------------------------------------------------------
- (void)addUser:(NSDictionary *)userDict {
    
//    UserModel *newUser = [[UserModel alloc] init];
//    newUser.name      = userDict[@"name"];
//    newUser.email     = userDict[@"email"];
//    newUser.username  = userDict[@"username"];
//    newUser.password  = userDict[@"password"];
//    newUser.userImage = userDict[@"userImage"];
//    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    
//    [realm transactionWithBlock:^{
//        [realm addObject:newUser];
//    }];
    
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.CoreDataService.persistentContainer.viewContext];
    
    newUser.name      = userDict[@"name"];
    newUser.email     = userDict[@"email"];
    newUser.username  = userDict[@"username"];
    newUser.password  = userDict[@"password"];
    newUser.userImage = userDict[@"userImage"];
    
    [self.CoreDataService saveContext];
}

//- (RLMResults *)fetchResultWithPredicate:(NSPredicate *)predicate {
//    RLMResults<UserModel *> *userResults = [UserModel objectsWithPredicate:predicate];
//    
//    return userResults;
//}

- (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate
{
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
    
    NSFetchRequest *request          = [User fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    [request setSortDescriptors:@[sortDescriptor]];
    _fetchedResultsController        = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                           managedObjectContext:self.CoreDataService.persistentContainer.viewContext
                                                                             sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Error Description: %@",[error userInfo]);
    }
    
    return _fetchedResultsController;
}

@end
