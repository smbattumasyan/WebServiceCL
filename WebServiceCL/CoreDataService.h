//
//  CoreDataService.h
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.//
//  Copyright © 2016 EGS. All rights reserved.


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataService : NSObject

#pragma Mark - Propertyes
@property (readonly, strong) NSPersistentContainer *persistentContainer;

#pragma Mark - Class Methods
+ (instancetype)defaultManager;
- (void)saveContext;

@end


