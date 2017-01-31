//
//  FriendsListModel.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 30.01.17.
//  Copyright © 2017 EGS. All rights reserved.
//

#import <Realm/Realm.h>

@interface FriendsListModel : RLMObject

@end

// This protocol enables typed collections. i.e.:
// RLMArray<FriendsListModel *><FriendsListModel>
RLM_ARRAY_TYPE(FriendsListModel)
