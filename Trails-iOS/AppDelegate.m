//
//  AppDelegate.m
//  Trails-iOS
//
//  Created by Georgi Christov on 08/04/2015.
//  Copyright (c) 2015 Callender Bell Development. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    
    NSString *activeStoryboardName;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:NOTIFICATION_LOG_IN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:NOTIFICATION_LOG_OUT object:nil];
    
    [self setupCache];
    
    // Clear app badge.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self checkLoginStatus];
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [TRSLifecycleManager applicationWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [TRSLifecycleManager applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Login

- (void)userDidLogin {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [self showStoryboardWithName:@"MainStoryboard" options:UIViewAnimationOptionTransitionCrossDissolve duration:0.7];
}

- (void)userDidLogout {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    [self showStoryboardWithName:@"LoginStoryboard" options:UIViewAnimationOptionTransitionCrossDissolve duration:0.7];
}

- (void)checkLoginStatus {
    [TRSUserManager checkLoginStatusWithSuccessBlock:^(TRSResponseObject *response) {
        [self checkLocalLoginStatus];
    } failureBlock:^(TRSResponseObject *response) {
        if (response.reason == OTHER)
            [self checkLocalLoginStatus];
        else {
            [TRSLifecycleManager setUser:nil];
            
            [self showStoryboardWithName:@"LoginStoryboard" options:UIViewAnimationOptionTransitionCrossDissolve duration:0.7];
        }
    }];
}

- (void)checkLocalLoginStatus {
    if ([TRSLifecycleManager isLoggedIn])
        [self userDidLogin];
    else
        [self showStoryboardWithName:@"LoginStoryboard" options:UIViewAnimationOptionTransitionCrossDissolve duration:0.7];
}

#pragma mark - Animations

- (void)showStoryboardWithName:(NSString *)name options:(UIViewAnimationOptions)options duration:(NSTimeInterval)duration {
    if (IS_IPAD)
        name = [NSString stringWithFormat:@"%@_ipad", name];
    
    if ([activeStoryboardName isEqualToString:name])
        return;
    
    activeStoryboardName = name;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *root = [storyboard instantiateInitialViewController];
    
    [self animateViewControllerSwitch:root options:options duration:duration];
}

- (void)animateViewControllerSwitch:(UIViewController *)vc options:(UIViewAnimationOptions)options duration:(NSTimeInterval)duration {
    [UIView
     transitionWithView:self.window
     duration:duration
     options:options
     animations:^(void) {
         BOOL oldState = [UIView areAnimationsEnabled];
         [UIView setAnimationsEnabled:NO];
         self.window.rootViewController = vc;
         [UIView setAnimationsEnabled:oldState];
     }
     completion:nil];
}

#pragma mark - Setup

- (void)setupCache {
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:500 * 1024 * 1024
                                                            diskCapacity:500 * 1024 * 1024
                                                                diskPath:@"cache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
}

@end
