//
//  UIImage+Utils.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 25/09/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size;

@end
