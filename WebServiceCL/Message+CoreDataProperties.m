//
//  Message+CoreDataProperties.m
//  
//
//  Created by Smbat Tumasyan on 06.02.17.
//
//  This file was automatically generated and should not be edited.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

+ (NSFetchRequest<Message *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

@dynamic conversation;
@dynamic date;
@dynamic user;

@end
