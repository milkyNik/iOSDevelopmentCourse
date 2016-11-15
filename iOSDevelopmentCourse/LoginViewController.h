//
//  LoginViewController.h
//  APITest
//
//  Created by iMac on 04.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessToken;

typedef void(^LoginComletionBlock)(AccessToken* token);

@interface LoginViewController : UIViewController

- (id) initWithCompletionBlock:(LoginComletionBlock) completionBlock;

@end
