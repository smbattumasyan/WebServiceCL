//
//  RealmManager.m
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 31.01.17.
//  Copyright © 2017 EGS. All rights reserved.
//

#import "RealmManager.h"

@implementation RealmManager

+ (instancetype)defaultManager {
    static RealmManager *defaultManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}


- (void)addUser:(NSDictionary *)userDict {
    
        UserModel *newUser = [[UserModel alloc] init];
        newUser.name      = userDict[@"name"];
        newUser.email     = userDict[@"email"];
        newUser.username  = userDict[@"username"];
        newUser.password  = userDict[@"password"];
        newUser.userImage = userDict[@"userImage"];
    
        RLMRealm *realm = [RLMRealm defaultRealm];
    
        [realm transactionWithBlock:^{
            [realm addObject:newUser];
        }];
}

- (RLMResults *)fetchResultWithPredicate:(NSPredicate *)predicate {
    RLMResults<UserModel *> *userResults = [UserModel objectsWithPredicate:predicate];
    
    return userResults;
}

@end
