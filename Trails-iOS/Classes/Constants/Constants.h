//
//  Constants.h
//  MyBabyPOC
//
//  Created by Georgi Christov on 10/18/13.
//  Copyright (c) 2013 Proxiad. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NAME @"Trails"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IS_LANDSCAPE ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IOS8_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define IS_IOS6_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
#define IS_IOS5_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0)

#define KEYBOARD_HEIGHT_IPHONE_P 216
#define KEYBOARD_HEIGHT_IPHONE_L 162
#define KEYBOARD_HEIGHT_IPAD_P 264
#define KEYBOARD_HEIGHT_IPAD_L 352
#define STATUSBAR_HEIGHT 20
#define NAVIGATIONBAR_HEIGHT 44
#define TOOLBAR_HEIGHT 40
#define TABBAR_HEIGHT 49

#define NOTIFICATION_LOG_IN @"NOTIFICATION_LOG_IN"
#define NOTIFICATION_LOG_OUT @"NOTIFICATION_LOG_OUT"

@interface Constants : NSObject

@end
