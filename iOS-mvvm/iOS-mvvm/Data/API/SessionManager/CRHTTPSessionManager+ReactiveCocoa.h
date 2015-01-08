//  CRHTTPSessionManager+ReactiveCocoa.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//
// Cloned by ReactiveCocoa+Overcoat
// more info https://github.com/gonzalezreal/Overcoat/tree/master/ReactiveCocoa%2BOvercoat


#import "CRHTTPSessionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Overcoat/Overcoat.h>

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)

@class RACSignal;

@interface CRHTTPSessionManager (ReactiveCocoa)

- (RACSignal *)executeRequest:(CRAPIRequest *)apiRequest;

@end

#endif
