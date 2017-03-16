//
//  User+CoreDataProperties.h
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *userImage;
@property (nullable, nonatomic, copy) NSString *username;
@property (nonatomic) int16_t userID;
@property (nullable, nonatomic, retain) NSSet<Message *> *message;
@property (nullable, nonatomic, retain) NSSet<Friends *> *friends;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessageObject:(Message *)value;
- (void)removeMessageObject:(Message *)value;
- (void)addMessage:(NSSet<Message *> *)values;
- (void)removeMessage:(NSSet<Message *> *)values;

- (void)addFriendsObject:(Friends *)value;
- (void)removeFriendsObject:(Friends *)value;
- (void)addFriends:(NSSet<Friends *> *)values;
- (void)removeFriends:(NSSet<Friends *> *)values;

@end

NS_ASSUME_NONNULL_END
