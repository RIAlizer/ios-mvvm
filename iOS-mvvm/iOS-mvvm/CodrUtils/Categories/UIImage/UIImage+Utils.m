//
//  UIImage+Utils.m
//  Codr Ltd
//
//  Created by Andrea Gonteri on 25/09/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)imageFromColor:(UIColor *)color
{
    return [UIImage imageFromColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
