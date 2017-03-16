//
//  Message+CoreDataProperties.h
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "Message+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

+ (NSFetchRequest<Message *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSString *conversation;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
