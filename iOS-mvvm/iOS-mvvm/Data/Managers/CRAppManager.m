//
//  CRAppManager.m
//  Codr Ltd
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR Ltd. All rights reserved.
//

#import "CRAppManager.h"

#import "DDASLLogger.h"
#import "DDTTYLogger.h"

#import "AFNetworkActivityLogger.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface CRAppManager ()

@end

@implementation CRAppManager

#pragma mark - Singleton

SYNTHESIZE_SINGLETON_FOR_CLASS(CRAppManager);

#pragma mark - Initialization

- (void)initApplicationWithWindow:(UIWindow*)window
{
    _mainWindow = window;
    
    [self initLogger];
    
    [self initNetworking];
    
    DDLogVerbose(@"CRAppManager initAppData");
    
    DDLogVerbose(LSTR(@"testLocalizedString"));

}

#pragma mark - Private

- (void)initLogger
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDLogError(@"This is an error.");
    DDLogWarn(@"This is a warning.");
    DDLogInfo(@"This is just a message.");
    DDLogVerbose(@"This is a verbose message.");
}

- (void)initNetworking
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //AFNetworkActivityLogger
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
#if DEBUG
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
#else
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelOff];
#endif
    
}

@end
