
//
//  CustomUIApplication.m
//  Codr Ltd
//
//  Created by Andrea Gonteri Codr Ltd on 28/10/2014.
//  Copyright (c) 2014 Codr Ltd Ltd. All rights reserved.
//
//-fno-objc-arc

#import "CustomUIApplication.h"
#import "LoggingAssertionHandler.h"

@implementation CustomUIApplication

#pragma mark - Static methods

+ (void)initialize
{
    //UIApplicationMemoryWarningNotification handler
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleMemoryWarning)
                                                name:@"UIApplicationMemoryWarningNotification"
                                              object:nil];
    
}


#pragma mark - Public methods

- (void)initApplication
{
    //register LoggingAssertionHandler
    NSAssertionHandler *assertionHandler = [[LoggingAssertionHandler alloc] init];
    [[[NSThread currentThread] threadDictionary] setValue:assertionHandler forKey:NSAssertionHandlerKey];
    [assertionHandler release];
    
    [self addUIApplicationStateObservers];
}

- (void)launchedApplication
{

}

#pragma mark - UIApplicationStateObservers

//register notification for UIApplicationState
- (void)addUIApplicationStateObservers
{
    NSNotificationCenter * defaultCenter = [NSNotificationCenter defaultCenter];
    
    //UIApplicationWillEnterForegroundNotification
    [defaultCenter addObserver:self
                      selector:@selector(applicationStateChangingNotification:)
                          name:UIApplicationWillEnterForegroundNotification
                        object:nil];
    //UIApplicationWillResignActiveNotification
    [defaultCenter
     addObserver:self
     selector:@selector(applicationStateChangingNotification:)
     name:UIApplicationWillResignActiveNotification object:nil];
    
    //UIApplicationDidEnterBackgroundNotification
    [defaultCenter
     addObserver:self selector:@selector(applicationStateChangingNotification:)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    //UIApplicationDidFinishLaunchingNotification
    [defaultCenter
     addObserver:self
     selector:@selector(applicationStateChangingNotification:)
     name:UIApplicationDidFinishLaunchingNotification
     object:nil];
    
    //UIApplicationDidBecomeActiveNotification
    [defaultCenter
     addObserver:self
     selector:@selector(applicationStateChangingNotification:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    
    //UIApplicationWillTerminateNotification
    [defaultCenter
     addObserver:self
     selector:@selector(applicationStateChangingNotification:)
     name:UIApplicationWillTerminateNotification
     object:nil];
}

- (void)applicationStateChangingNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationWillEnterForegroundNotification])
    {
        DDLogVerbose(@"UIApplicationWillEnterForegroundNotification");
    }
    else if([notification.name isEqualToString:UIApplicationWillResignActiveNotification])
    {
        DDLogVerbose(@"UIApplicationWillResignActiveNotification");
    }
    else if([notification.name isEqualToString:UIApplicationWillTerminateNotification])
    {
        DDLogVerbose(@"UIApplicationWillTerminateNotification");
    }
    else if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        DDLogVerbose(@"UIApplicationDidBecomeActiveNotification");
    }
    else
    {
        DDLogVerbose(@"UIApplication state: %@",notification.name);
    }
    
}

- (void)handleMemoryWarning
{
    NSLog(@"%@ %@",[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSASCIIStringEncoding],@"Should I manage handleMemoryWarning? ");
}

@end
