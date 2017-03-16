//
//  User+CoreDataProperties.m
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic email;
@dynamic name;
@dynamic password;
@dynamic userImage;
@dynamic username;
@dynamic userID;
@dynamic message;
@dynamic friends;

@end
