//
//  User.h
//  APITest
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerObject.h"

@interface User : ServerObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageUrl;

@end
