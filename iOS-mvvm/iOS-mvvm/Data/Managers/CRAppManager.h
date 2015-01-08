//
//  CRAppManager.h
//  Codr Ltd
//
//  Created by Andrea Gonteri iWoo on 24/09/2014.
//  Copyright (c) 2014 Iwoo Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonHelper.h"

/**
 Application Manager (singleton)
 It manages the app properties and common methods
 */
@interface CRAppManager : NSObject

/**
 The main App Window
 */
@property (nonatomic, strong) UIWindow * mainWindow;

/**
 The splashViewController
 */
@property (nonatomic, strong) UIViewController * splashViewController;

/**
 The appRootViewController 
 */
@property (nonatomic, strong) UIViewController * appRootViewController;

- (void)initApplicationWithWindow:(UIWindow*)window;

@end

