//
//  CustomUIApplication.h
//  Codr Ltd
//
//  Created by Andrea Gonteri Codr Ltd on 28/10/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//-fno-objc-arc

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <execinfo.h>
#import <libkern/OSAtomic.h>

/**
 'CustomUIApplication' contains methods, hacking and logs useful during development and Beta Testing
 */
@interface CustomUIApplication : UIResponder <UIApplicationDelegate>

- (void)initApplication;

- (void)launchedApplication;

@end
