//
//  User+CoreDataProperties.m
//  
//
//  Created by Smbat Tumasyan on 26.12.16.
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
@dynamic username;
@dynamic userImage;

@end
