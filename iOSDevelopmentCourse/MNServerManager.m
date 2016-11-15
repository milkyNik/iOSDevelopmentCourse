//
//  MNServerManager.m
//  iOSDevelopmentCourse
//
//  Created by iMac on 15.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "MNServerManager.h"
#import "AFNetworking.h"
#import "User.h"
#import "LoginViewController.h"
#import "AccessToken.h"

@interface MNServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* requestSessionManager;
@property (strong, nonatomic) AccessToken* accessToken;


@end

@implementation MNServerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* baseUrl = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
 
    }
    return self;
}



+ (MNServerManager*) sharedManager {
    
    static MNServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MNServerManager alloc] init];
    });
    
    return manager;
    
}

#pragma mark - Authorize

- (void) authorizeUser:(void(^)(User* user)) completion {
    
    LoginViewController* loginViewController = [[LoginViewController alloc] initWithCompletionBlock:^(AccessToken *token) {
        
        self.accessToken = token;
        
        [self getUserInfoByUserID:@[token.userId]
                       withFields:@[@"photo_50"]
                        onSuccess:^(NSArray *users) {
                            
                            _currentUser = [users firstObject];
                            
                            if (completion) {
                                completion([users firstObject]);
                            }
                            
                        } onFailure:^(NSError *error) {
                            NSLog(@"%@", [error localizedDescription]);
                        }];
        
        
        
        
        NSLog(@"%@", self.accessToken);
        
        
        
    }];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    UIViewController* mainViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [mainViewController presentViewController:navigationController
                                     animated:YES
                                   completion:nil];
    
}


- (void) getUserInfoByUserID:(NSArray*) usersId
                  withFields:(NSArray*) fieldsArray
                   onSuccess:(void(^)(NSArray* users)) success
                   onFailure:(void(^)(NSError* error)) failure {
    
    NSLog(@"getUserInfoByUserID");
    
    NSDictionary* params = @{
                             @"user_ids"    : usersId,
                             @"name_case"   : @"nom",
                             @"fields"      : fieldsArray};
    
    [self.requestSessionManager GET:@"users.get" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* dictionarysArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray* users = [NSMutableArray array];
        
        for (NSDictionary* response in dictionarysArray) {
            
            [users addObject:[[User alloc] initWithServerResponse:response]];
            
        }
        
        if (success) {
            
            success(users);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}


/*
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
[manager GET:@"http://example.com/resources.json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];*/

@end
