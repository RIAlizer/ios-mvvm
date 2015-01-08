//
//  UIColor+Hex.m
//  Codr Ltd
//
//  Created by Andrea Gonteri on 24/09/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor*)colorWithHex:(long)hexColor;
{
    return [UIColor
            colorWithHex:hexColor
            alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor
            colorWithRed:red
            green:green
            blue:blue
            alpha:opacity];
}

+ (UIColor *)getRandomColor
{
    return [self getRandomColorWithAlphaPercentage:100];
}

+ (UIColor *)getRandomColorWithAlphaPercentage:(NSInteger)alphaPercentage
{
    return [UIColor
            colorWithRed:(random()%100)/(float)100
            green:(random()%100)/(float)100
            blue:(random()%100)/(float)100
            alpha:(random()%alphaPercentage)/(float)100];
}

@end
