//
//  UIImage+Tint.m
//  EZtrans
//
//  Created by Georgi Christov on 1/21/14.
//  Copyright (c) 2014 Georgi Christov. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTint:(UIColor *)c {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = (CGRect){ CGPointZero, self.size };
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [self drawInRect:rect];
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [c setFill];
    CGContextFillRect(context, rect);
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
