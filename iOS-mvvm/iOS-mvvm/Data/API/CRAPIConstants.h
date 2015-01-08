//
//  CRAPIConstants.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

//// *** Enums ****//

/**
 CRAPIRequestMethod enum.
 Use CRAPIRequestMethodGET to perform a GET by ID request
 Use CRAPIRequestMethodLIST to perform a GET request

 */
typedef NS_ENUM(NSUInteger, CRAPIRequestMethod)
{
    CRAPIRequestMethodGET = 0,
    CRAPIRequestMethodLIST,//a new rest method!
    CRAPIRequestMethodHEAD,
    CRAPIRequestMethodPOST,
    CRAPIRequestMethodPUT,
    CRAPIRequestMethodPATCH,
    CRAPIRequestMethodDELETE
};

typedef NS_ENUM(NSUInteger, CRAPIRequestType)
{
    CRAPIRequestTypeInvalid = 0,
    CRAPIRequestTypeImagesSearch,
    CRAPIRequestTypeImages,
};

/* Constants */

//// **** Staging **** //
static NSString * const kCRShutterStockAPIBaseURL = @"https://api.shutterstock.com";
static NSString * const kCRShutterStockAPIVersion = @"v2";

///// *** Block defintion ***//

//typedef void (^SessionTaskSuccess)(NSURLSessionDataTask *task, id responseObject);
//typedef void (^SessionTaskFailure)(NSURLSessionDataTask *task, NSError *error);

//The timeout interval, in seconds, for created requests. The default timeout interval is 60 seconds.
static NSInteger const kCRAPITimeoutIntervalForRequest = 40;

static NSString * const kCRAPIClientID = @"1384f202b7c587401d6e";
static NSString * const kCRAPIClientSecret = @"75a98f5c9c053de82b8c6d2bed83027d6bbffed8";

