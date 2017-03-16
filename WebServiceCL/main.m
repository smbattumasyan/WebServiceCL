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
        NSLog(@"system: %d", system("pwd"));
        Helper *helper = [[Helper alloc] init];
        [helper loginRegistration];
    }
    return 0;
}


