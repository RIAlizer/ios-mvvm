//
//  IWDevDefines.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 24/09/2014.
//  Copyright (c) 2014 Codr Ltd Ltd. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <stdlib.h>

#pragma mark - Inline Functions

/**
 Simplify NSLocalizedString (debug/development purpouse)
 Inline function to enable/disable NSLocalizedString based on EnvVar DISABLE_LOCALIZATION
 */
static inline NSString * LSTR(NSString* str, ...)
{
    if(getenv("DISABLE_LOCALIZATION") != NULL)
        return str;
    else
        return NSLocalizedString(str, ##__VA_ARGS__);
}

/**
 Get NSString from BOOL (@"YES" | @"NO")
*/
static inline NSString * NSStringFromBool(BOOL value, ...)
{
    NSString *stringValue = value? @"YES" : @"NO";
    return stringValue;
}

/**
 Check if and object isEmpty or nil 
 (NSString, NSData, NSSet, NSNull)
 */
static inline BOOL IsEmpty(id thing)
{
    return thing == nil
    
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSSet *)thing count] == 0)
    || ([thing respondsToSelector:@selector(allKeys)]
        && [[thing allKeys] count]==0)
    || [thing isKindOfClass:[NSNull class]];// && [(NSArray *)thing count] == 0);
}

/**
 GCD to perform task in main thread
 more info http://stackoverflow.com/questions/5662360/gcd-to-perform-task-in-main-thread
 */
static inline void dev_runOnMainQueueWithoutDeadlocking(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

/**
 GCD to execute a block after a given delay
 more info http://stackoverflow.com/questions/5662360/gcd-to-perform-task-in-main-thread
 */
static inline void dev_runBlockAfterDelay(NSTimeInterval secondsToWait, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secondsToWait*NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

/**
 Override @autoreleasepool (debug/development purpouse)
 enable/disable autoreleasepool according to preprocessor Macro AUTORELEASE_POOL_ENABLED
 */
static inline void dev_runOnAutoreleasePool(void (^block)(void))
{
#if AUTORELEASE_POOL_ENABLED
    @autoreleasepool {
        block();
    }
#else
    block();
#endif
}

#pragma mark - Macros Defines

/**
 Safe remove submviews
 */
#define SAFE_REMOVE_SUBVIEWS(theView) for (int i=0; i<[theView.subviews count]; ++i){ if([[theView.subviews objectAtIndex:i] respondsToSelector:@selector(removeFromSuperview)])   [[theView.subviews objectAtIndex:i] removeFromSuperview];}

/**
 Simplify Device Info
 */
#define IS_IPAD  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

/**
 Simplify Retina detection
 */
#define IS_RETINA  [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2

/**
 Simplify iOS detection
 */

#define IS_IOS7  [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){7, 0, 0}]

/**
 Simplify iOS detection
 */

#define IS_IOS8  [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8, 0, 0}]

/**
 Degrees to radians functions
 */
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

/**
 interface orientation
 */
#define INTERFACE_ORIENTATION_LANDSCAPEALL				((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight))
#define INTERFACE_ORIENTATION_LANDSCAPELEFT				(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
#define INTERFACE_ORIENTATION_LANDSCAPERIGHT			(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
#define INTERFACE_ORIENTATION_PORTRAITALL				((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
#define INTERFACE_ORIENTATION_PORTRAIT					(interfaceOrientation == UIInterfaceOrientationPortrait)
#define INTERFACE_ORIENTATION_PORTRAIT_UPSIDEDOWN		(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
#define INTERFACE_ORIENTATION_FREE

#define INTERFACE_ORIENTATION_IS_PORTRAIT  ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown)


#pragma mark - Macros fucntions

/**
 Inline function to display UIAlertView with a message
 only for development purpouse
 */
#if DEBUG
#   define dev_showUIAlertViewDebug(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else

#   define dev_showUIAlertViewDebug(fmt, ...)  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

/**
 Supress 'performSelector' warnings
 */
#define dev_PerformSelectorWithoutWarnings(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)




