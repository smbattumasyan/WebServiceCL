//
//  Friends+CoreDataProperties.h
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "Friends+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Friends (CoreDataProperties)

+ (NSFetchRequest<Friends *> *)fetchRequest;

@property (nonatomic) int16_t userID;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
