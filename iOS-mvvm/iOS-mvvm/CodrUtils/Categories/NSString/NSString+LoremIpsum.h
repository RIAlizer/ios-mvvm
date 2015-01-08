//
//  NSString+LoremIpsum.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 30/09/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `NSString+LoremIpsum` contains Mock functions useful for testing purpouse
 */
@interface NSString (LoremIpsum)

+ (NSString *)randomLorumIpsum;

+ (NSString *)randomString;

+ (NSString *)randomStringWithLength:(NSUInteger)len;

@end
