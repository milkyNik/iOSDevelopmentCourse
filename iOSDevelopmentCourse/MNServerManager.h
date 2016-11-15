//
//  MNServerManager.h
//  iOSDevelopmentCourse
//
//  Created by iMac on 15.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface MNServerManager : NSObject

@property (strong, nonatomic, readonly) User* currentUser;

+ (MNServerManager*) sharedManager;

- (void) authorizeUser:(void(^)(User* user)) completion;

- (void) getUserInfoByUserID:(NSArray*) usersId
                  withFields:(NSArray*) fieldsArray
                   onSuccess:(void(^)(NSArray* users)) success
                   onFailure:(void(^)(NSError* error)) failure;

@end
