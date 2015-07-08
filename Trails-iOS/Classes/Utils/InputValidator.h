//
//  InputValidator.h
//  GraffiTab-iOS
//
//  Created by Georgi Christov on 26/11/2014.
//  Copyright (c) 2014 GraffiTab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputValidator : NSObject

+ (BOOL)validateLoginInput:(NSString *)username password:(NSString *)password viewController:(UIViewController *)vc;

@end
