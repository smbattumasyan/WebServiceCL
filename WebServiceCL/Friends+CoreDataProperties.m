//
//  Friends+CoreDataProperties.m
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "Friends+CoreDataProperties.h"

@implementation Friends (CoreDataProperties)

+ (NSFetchRequest<Friends *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Friends"];
}

@dynamic userID;
@dynamic user;

@end
