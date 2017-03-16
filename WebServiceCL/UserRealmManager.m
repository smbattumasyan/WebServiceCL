//
//  RealmManager.m
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 31.01.17.
//  Copyright © 2017 EGS. All rights reserved.
//

#import "UserRealmManager.h"

@implementation UserRealmManager

+ (instancetype)defaultManager {
    static UserRealmManager *defaultManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}

- (void)addUser:(NSDictionary *)userDict {
}

- (RLMResults *)fetchResultWithPredicate:(NSPredicate *)predicate {
    RLMResults<UserModel *> *userResults = [UserModel objectsWithPredicate:predicate];
    
    return userResults;
}

@end
