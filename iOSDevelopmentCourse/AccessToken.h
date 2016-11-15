//
//  AccessToken.h
//  APITest
//
//  Created by iMac on 04.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userId; 

- (instancetype) initWithNSURLRequest:(NSURLRequest*) request;

@end
