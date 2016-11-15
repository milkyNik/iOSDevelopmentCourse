//
//  LoginViewController.m
//  APITest
//
//  Created by iMac on 04.11.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "LoginViewController.h"
#import "AccessToken.h"

@interface LoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) LoginComletionBlock completionBlock;
@property (weak, nonatomic) UIWebView* webView;

@end

@implementation LoginViewController

- (id) initWithCompletionBlock:(LoginComletionBlock) completionBlock
{
    self = [super init];
    if (self) {
        
        self.completionBlock = completionBlock;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:rect];
    
    webView.delegate = self;
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.webView = webView;
    
    [self.view addSubview:webView];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(actionCancel:)];

    [self.navigationItem setRightBarButtonItem:cancelButton];
    
    self.navigationItem.title = @"Login";
    
    NSString* loginString = @"https://oauth.vk.com/authorize?"
                            "client_id=5710669&"
                            "display=mobile&"
                            "redirect_uri=https://oauth.vk.com/blank.html&"
                            "scope=139286&"
                            "response_type=token&"
                            "v=5.60&"
                            "state=123456";
    //&""revoke=1
    
    NSURL* loginUrl = [NSURL URLWithString:loginString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:loginUrl];
    
    [webView loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem*) item {
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    if ([[[request URL] absoluteString] rangeOfString:@"#access_token="].location != NSNotFound) {
        AccessToken* token = [[AccessToken alloc] initWithNSURLRequest:request];
        self.completionBlock(token);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    /*
    
    if (token.token) {
        
    } */
    
    
    
    return YES;
}

@end















