//
//  TermsViewController.m
//  DigiGraff-IOS
//
//  Created by Georgi Christov on 26/11/2014.
//  Copyright (c) 2014 DigiGraff. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController () {
    
    IBOutlet UIWebView *webview;
}

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTopBar];
    
    [self loadText];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadText {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"txt"];
    BOOL loaded = YES;
    
    if ( filePath ) {
        NSError *e;
        NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&e];
        
        if ( myText )
            [webview loadHTMLString:myText baseURL:nil];
        else {
            loaded = NO;
        }
    }
    else {
        loaded = NO;
    }
}

#pragma mark - Setup

- (void)setupTopBar {
    self.title = @"Terms of Use";
}

@end
