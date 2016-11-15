//
//  AccessToken.m
//  APITest
//
//  Created by iMac on 04.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

- (instancetype)initWithNSURLRequest:(NSURLRequest*) request
{
    self = [super init];
    if (self) {
        
        NSString* query = [[request URL] absoluteString];
        
        NSArray* tmpArray = [query componentsSeparatedByString:@"#"];
        
        if ([tmpArray count] > 1) {
            
            query = [tmpArray lastObject];
            
        }
        
        tmpArray = [query componentsSeparatedByString:@"&"];
        
        for (NSString* tmpStr in tmpArray) {
            
            NSArray* pair = [tmpStr componentsSeparatedByString:@"="];
            
            if ([[pair firstObject] isEqualToString:@"access_token"]) {
                
                self.token = [pair lastObject];
                
            } else if ([[pair firstObject] isEqualToString:@"expires_in"]) {
                
                NSTimeInterval interval = [[pair lastObject] doubleValue];
                
                self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                
            } else if ([[pair firstObject] isEqualToString:@"user_id"]) {
                
                self.userId = [pair lastObject];
                
            }
            
        }
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\ntoken = %@ \ndate = %@ \nuser = %@", self.token, self.expirationDate, self.userId];
    
}

@end
