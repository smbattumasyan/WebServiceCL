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
#import "CoreDataManager.h"
#import <CoreImage/CoreImage.h>
#import <Realm/Realm.h>
#import "DatabaseManager.h"
#import "RealmManager.h"

@interface Helper () <DatabaseManagerProtocol>

//-------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//-------------------------------------------------------------------------------------------
@property (strong, nonatomic) GCDWebServer *webServer;
@property (strong, nonatomic) id<DatabaseManagerProtocol> dataManager;

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
        self.dataManager = [CoreDataManager defaultManager];
    }
    return self;
}
- (void)loginRegistration {

//    UMManager *umManager = [UMManager defaultManager];
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
                      
                          NSPredicate *predicate     = [NSPredicate predicateWithFormat:@"username==%@ AND password ==%@", username, password];
                          NSDictionary *responseDict = [helper getUserDataWithPredicate:predicate];

//                          CIImage *img               = [CIImage imageWithData:[helper stringToData:responseDict[@"userImage"]]];
//                          NSLog(@"responseDict:%@", img);
                          
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
                               [helper.dataManager addUser:userDict];

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
    
    
    
    if ([self.dataManager isKindOfClass:[CoreDataManager class]]) {
            [self.dataManager fetchedResultsControllerWithPredicate:predicate];
        
            NSError *error = nil;
            if (![[self.dataManager fetchedResultsController] performFetch:&error]) {
                // Handle error
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                exit(-1);  // Fail
            }
        
        
        NSArray *result = [self.dataManager.fetchedResultsController fetchedObjects];
        
        if (result.count == 0) {
            return nil;
        }
        //                          for (User *usr in result) {
        //                              NSLog(@"400 000 rslt: %@ %@ %@ %@",usr.name, usr.username, usr.password, usr.email);
        //                          }
        
        
        User *usr                  = [result lastObject];
        NSLog(@"usr: %@", usr.password);
        NSDictionary *responseDict = @{@"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return responseDict;
        
    } else if ([self.dataManager isKindOfClass:[RealmManager class]]) {
        
        RLMResults *result = [self.dataManager fetchResultWithPredicate:predicate];
        
        if (result.count == 0) {
            return nil;
        }
        
        UserModel *usr                  = [result lastObject];
        NSLog(@"usr: %@", usr.password);
        NSDictionary *responseDict = @{@"name" : usr.name, @"email" : usr.email, @"userImage" :usr.userImage};
        return responseDict;
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
