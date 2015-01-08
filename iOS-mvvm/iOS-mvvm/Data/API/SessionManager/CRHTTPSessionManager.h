//
//  CRHTTPSessionManager.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVCHTTPSessionManager.h"
#import "CRAPIRequest.h"

/**
 `CRHTTPSessionManager` manages the HTTP Request
 */
@interface CRHTTPSessionManager : OVCHTTPSessionManager

@property (nonatomic, strong) CRAPIRequest *apiRequest;
@property (nonatomic, strong) NSString *userAuthToken;

+ (instancetype)sharedInstance;

- (void)setUserAuthToken:(NSString *)userAuthToken;

/**
Sets sessionManager options for the given ApiRequest (IE: set securityPolicy)
 @param CRAPIRequest the apiRequest
 */
- (void)setSessionManagerOptionsforRequest:(CRAPIRequest*)apiRequest;

- (void)forceUseStubRequest;

@end
