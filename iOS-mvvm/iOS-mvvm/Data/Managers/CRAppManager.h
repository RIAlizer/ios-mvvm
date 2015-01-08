//
//  CRAppManager.h
//  Codr Ltd
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR Ltd. All rights reserved.
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

