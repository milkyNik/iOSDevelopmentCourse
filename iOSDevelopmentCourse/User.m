//
//  User.m
//  APITest
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithServerResponse:(NSDictionary*) dictionaryResponse
{
    self = [super initWithServerResponse:dictionaryResponse];
    if (self) {
        
        self.firstName = dictionaryResponse[@"first_name"];
        self.lastName = dictionaryResponse[@"last_name"];
        self.imageUrl = [NSURL URLWithString:dictionaryResponse[@"photo_50"]];
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\nfirstName = %@\nlastName = %@\nimageUrl = %@", _firstName, _lastName, _imageUrl];
    
}



@end
