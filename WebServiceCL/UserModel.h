//
//  UserModel.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 27.01.17.
//  Copyright © 2017 EGS. All rights reserved.
//

#import <Realm/Realm.h>

@interface UserModel : RLMObject

@property NSString *username;
@property NSString *password;
@property NSString *name;
@property NSString *email;
@property NSString *userImage;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<UserModel *><UserModel>
RLM_ARRAY_TYPE(UserModel)


