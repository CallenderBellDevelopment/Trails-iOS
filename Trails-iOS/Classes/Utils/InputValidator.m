//
//  InputValidator.m
//  GraffiTab-iOS
//
//  Created by Georgi Christov on 26/11/2014.
//  Copyright (c) 2014 GraffiTab. All rights reserved.
//

#import "InputValidator.h"

@implementation InputValidator

+ (BOOL)validateLoginInput:(NSString *)username password:(NSString *)password viewController:(UIViewController *)vc {
    if (username.length <= 0)
        return NO;
    if (password.length <= 0)
        return NO;
    
    return YES;
}

@end
