//
//  CRDefines.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 24/09/2014.
//  Copyright (c) 2014 Codr Ltd. All rights reserved.
//

#pragma once

#import <stdlib.h>
#import "DevDefines.h"

//Lumberjack Log Level
static const int ddLogLevel = LOG_LEVEL_ALL;

//MACROS defined in Target Settings
#ifndef DEBUG_USING_STUB_REQUEST
    #define DEBUG_USING_STUB_REQUEST 1
#endif

//enable/disable forcing throw exception on Assert Failure
#ifndef kLoggingAssertionHandlerForceExceptions
    #define kLoggingAssertionHandlerForceExceptions 1
#endif

#ifndef DISABLE_MBPROGRESS_HUD
    #define DISABLE_MBPROGRESS_HUD 0
#endif

/* App Environment Macros*/

//enable PRODUCTION endpoint
#ifndef PRODUCTION
    #define PRODUCTION 0
#endif

/**
 BETA Features:
 - useGlobalExceptionHandling enabled
 */
//enable BETA features
#ifndef BETA
    #define BETA 1
#endif

/* App Development Macros*/

//enable DEBUG info
#ifndef DEBUG
    #define DEBUG 0
#endif

//Allow USE_GLOBAL_EXCEPTIONS_HANDLER!!
#ifndef USE_GLOBAL_EXCEPTIONS_HANDLER
    #define USE_GLOBAL_EXCEPTIONS_HANDLER 1
#endif

//enable ENABLE_LOCALIZATION, enable LSTR conversion
#ifndef ENABLE_LOCALIZATION
    #define ENABLE_LOCALIZATION 1
#endif

//enable LOGGING_ENABLED, enable Logging Behavior
#ifndef LOGGING_ENABLED
    #define LOGGING_ENABLED 1
#endif

//enable AUTORELEASE_POOL_ENABLED info
#ifndef AUTORELEASE_POOL_ENABLED
    #define AUTORELEASE_POOL_ENABLED 1
#endif

//enable DEBUG_AFNETWORKING, enable debugging AFNETWORKING
#ifndef DEBUG_AFNETWORKING
    #define DEBUG_AFNETWORKING 1
#endif

//enable ENABLE_TEST_UI, enable/disable Test UI
#ifndef ENABLE_TEST_UI
    #define ENABLE_TEST_UI 0
#endif

//enable ENABLE_CHECK_SCREENSHOTS, enable/disable Test UI
#ifndef ENABLE_CHECK_SCREENSHOTS
    #define ENABLE_CHECK_SCREENSHOTS 0
#endif

/* App Animations/Transitions Macros*/

//disable ENABLE_VIEW_ANIMATION, disable/enable UIView animation (UIView+IWAnimation)
#ifndef ENABLE_VIEW_ANIMATION
    #define ENABLE_VIEW_ANIMATION 1
#endif

//disable ENABLE_CUSTOM_MODAL_TRANSITION, disable/enable custom modal transit
#ifndef ENABLE_CUSTOM_MODAL_TRANSITION
    #define ENABLE_CUSTOM_MODAL_TRANSITION 1
#endif

//default fade in duration during transition
#define DEFAULT_FADE_IN_DURATION 0.4f

//default fade out duration during transition
#define DEFAULT_FADE_OUT_DURATION 0.3f

//timeInterval during fake request
#define CRAPIRequest_STUB_FAKE_TIMEOUT_SLEEP 2//seconds

//timeInterval during splash view

#if DEBUG
    #define APP_SPLASH_DELAY_DURATION 0.1 //seconds
#else
    #define APP_SPLASH_DELAY_DURATION 3.0 //seconds
#endif


//-------------------------------------------------------


//FIXME: create a new file to collect common App typedef, macros, etc
//-------------------------------------------------------
//typedef void(^SuccessBlock)(id result);
//typedef void(^FailureBlock)(NSError *error);

static CGFloat const kCRPasswordMinLength = 8;
static CGFloat const kCRPasswordMaxLength = 30;
//-------------------------------------------------------

typedef void(^IWSuccessBlock)(id result);
typedef void(^IWFailureBlock)(NSError *error);


#define FAKE_USER_IMAGE @"http://ballmeripsum.com/img/ballmer.jpg"
