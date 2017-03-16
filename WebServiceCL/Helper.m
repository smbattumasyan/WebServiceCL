//
//  Helper.m
//  WebServiceCL
//
//  Created by Smbat Tumasyan on 16.12.16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "Helper.h"
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerURLEncodedFormRequest.h>
#import "UserCoreDataManager.h"
#import <CoreImage/CoreImage.h>
#import <Realm/Realm.h>
#import "DatabaseManager.h"
#import "UserRealmManager.h"

@interface Helper () <DatabaseManagerProtocol>

//-------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//-------------------------------------------------------------------------------------------
@property (strong, nonatomic) GCDWebServer *webServer;
@property (strong, nonatomic) id<DatabaseManagerProtocol> userDataManager;

@end

@implementation Helper

//-------------------------------------------------------------------------------------------
#pragma mark - Public Methods
//-------------------------------------------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webServer = [[GCDWebServer alloc] init];
        self.userDataManager = [UserCoreDataManager defaultManager];
    }
    return self;
}
- (void)loginRegistration {

    __block Helper *helper = self;
    
    [self.webServer addHandlerForMethod:@"POST"
                              path:@"/login"
                      requestClass:[GCDWebServerURLEncodedFormRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                          
                          NSString* username = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"username"];
                          NSString* password = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"password"];
                          
                          if (username == nil || password == nil || [username  isEqual: @""] || [username isEqualToString:@""]) {
                              return nil;
                          }
                          
                          NSLog(@"allObjects: %@", [helper getAllUsers]);
                      
                          NSPredicate *predicate     = [NSPredicate predicateWithFormat:@"username==%@ AND password ==%@", username, password];
                          NSDictionary *responseDict = [helper getUserDataWithPredicate:predicate];

                          if (responseDict == nil) {
                              return nil;
                          }
                          
                          return [GCDWebServerDataResponse responseWithJSONObject:responseDict contentType:@"application/x-www-form-urlencoded"];
                      }];
    
    [self.webServer addHandlerForMethod:@"POST"
                                   path:@"/registration"
                           requestClass:[GCDWebServerURLEncodedFormRequest class]
                           processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                               
                               NSString* username  = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"username"];
                               NSString* password  = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"password"];
                               NSString* name      = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"name"];
                               NSString* email     = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"email"];
                               NSString* userImage = [[(GCDWebServerURLEncodedFormRequest*)request arguments] objectForKey:@"userImage"];
                               
                               
                               
                               NSDictionary *userDict     = @{@"username" : username, @"password" : password, @"name" : name, @"email" :email, @"userImage" :userImage};
                               [helper.userDataManager addUser:userDict];

                               NSPredicate *predicate     = [NSPredicate predicateWithFormat:@"username==%@ AND password ==%@", username, password];
                               NSDictionary *responseDict = [helper getUserDataWithPredicate:predicate];
                               
                               return [GCDWebServerDataResponse responseWithJSONObject:responseDict contentType:@"application/x-www-form-urlencoded"];
                           }];
    
    [self.webServer runWithPort:8080 bonjourName:nil];
    NSLog(@"____Visit %@ in your web browser", self.webServer.serverURL);
}

//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------
- (NSDictionary *)getUserDataWithPredicate:(NSPredicate *)predicate {
    
    if ([self.userDataManager isKindOfClass:[UserCoreDataManager class]]) {
            [self.userDataManager fetchedResultsControllerWithPredicate:predicate];
        
            NSError *error = nil;
            if (![[self.userDataManager fetchedResultsController] performFetch:&error]) {
                // Handle error
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                exit(-1);  // Fail
            }
        
        
        NSArray *result = [self.userDataManager.fetchedResultsController fetchedObjects];
        
        if (result.count == 0) {
            return nil;
        }
        //                          for (User *usr in result) {
        //                              NSLog(@"400 000 rslt: %@ %@ %@ %@",usr.name, usr.username, usr.password, usr.email);
        //                          }
        
        User *usr                  = [result lastObject];
        NSLog(@"usr: %@", usr.password);
        NSDictionary *responseDict = @{@"username" : usr.username, @"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return responseDict;
        
    } else if ([self.userDataManager isKindOfClass:[UserRealmManager class]]) {
        
        RLMResults *result = [self.userDataManager fetchResultWithPredicate:predicate];
        
        if (result.count == 0) {
            return nil;
        }
        
        UserModel *usr                  = [result lastObject];
        NSLog(@"usr: %@", usr.password);
        NSDictionary *responseDict = @{@"username" : usr.username, @"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return responseDict;
    }
    
    
    return nil;
}

-(NSArray *)getAllUsers {
    
    if ([self.userDataManager isKindOfClass:[UserCoreDataManager class]]) {
        
        [self.userDataManager fetchedResultsControllerWithPredicate:nil];
        NSError *error = nil;
        if (![[self.userDataManager fetchedResultsController] performFetch:&error]) {
            // Handle error
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
        
        
        NSArray *result = [self.userDataManager.fetchedResultsController fetchedObjects];
        
        if (result.count == 0) {
            return nil;
        }
        //                          for (User *usr in result) {
        //                              NSLog(@"400 000 rslt: %@ %@ %@ %@",usr.name, usr.username, usr.password, usr.email);
        //                          }
        
//        User *usr                  = [result lastObject];
//        NSLog(@"usr: %@", usr.password);
//        NSDictionary *responseDict = @{@"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return result;
        
    } else if ([self.userDataManager isKindOfClass:[UserRealmManager class]]) {
        
        RLMResults *result = [self.userDataManager fetchResultWithPredicate:nil];
        
        NSMutableArray *resultList = [NSMutableArray array];
        for (RLMObject *object in result) {
            [resultList addObject:object];
        }
        
        if (result.count == 0) {
            return nil;
        }
//        
//        UserModel *usr                  = [result lastObject];
//        NSLog(@"usr: %@", usr.password);
//        NSDictionary *responseDict = @{@"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return resultList;
    }
    
    
    return nil;
}

- (NSString *)jsonStringWithPrettyPrint:(NSDictionary *)dictionary
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint:error:%@",error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (NSData *)stringToData:(NSString *)string
{
    string       = [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return data;
}


@end
