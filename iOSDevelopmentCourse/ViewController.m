//
//  ViewController.m
//  iOSDevelopmentCourse
//
//  Created by iMac on 15.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "MNServerManager.h"

@interface ViewController ()

@property (strong, nonatomic) User* currentUser;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[MNServerManager sharedManager] authorizeUser:^(User *user) {
        
        self.currentUser = user;
        
        NSLog(@"%@", self.currentUser);
        
    }];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
