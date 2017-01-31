//
//  main.m
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"
#import "UserModel.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        system("ffmpeg -i input.jpg -vf scale=320:-1 output_320.png");
        
        
//        UserModel *myUserModel = [[UserModel alloc] init];
//        myUserModel.username = @"userAnun";
//        myUserModel.password = @"parol";
//        myUserModel.name = @"anun";
//        myUserModel.userImage = nil;
//        
//        RLMRealm *realm = [RLMRealm defaultRealm];
//        
//        [realm transactionWithBlock:^{
//            [realm addObject:myUserModel];
//        }];
//        
//        RLMResults<UserModel *> *userResults = [UserModel allObjects];
//        
//        NSLog(@"allObjecrts: %@", userResults);
        
        Helper *helper = [[Helper alloc] init];
        [helper loginRegistration];
    }
    return 0;
}


