//
//  Helper.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

#pragma mark - Public Methods
- (NSString *)jsonStringWithPrettyPrint:(NSDictionary *)dictionary;
- (void)loginRegistration;

@end
