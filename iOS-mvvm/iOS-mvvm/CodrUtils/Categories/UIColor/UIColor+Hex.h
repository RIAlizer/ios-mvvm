//
//  UIColor+Hex.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 24/09/2014.
//  Copyright (c) 2014 Codr Ltd Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 Retrieve a color with the given exadecimal code with alpha 1
 @param long hexColor (IE 0xffffff)
 @returns proper UIColor
 */
+ (UIColor*)colorWithHex:(long)hexColor;

/**
 Retrieve a color with the given exadecimal code and alpha value
 @param long hexColor (IE 0xffffff)
 @param float opacity
 @returns proper UIColor
 */
+ (UIColor*)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *)getRandomColor;

+ (UIColor *)getRandomColorWithAlphaPercentage:(NSInteger)alphaPercentage;

@end
