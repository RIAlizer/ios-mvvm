//
//  CRAPIRequest.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRBaseModel.h"
#import "CRAPIConstants.h"
#import "CRShutterStockImage.h"

//FOUNDATION_EXPORT NSString * const kCRErrorCode;
//FOUNDATION_EXPORT NSString * const kCRErrorMessage;

/**
 kCRAPIEndpoint
 the URL should include '#' (OVCURLMatcherTypeNumber) or '*' OVCURLMatcherTypeText 
 the URL should NOT start with '/'
 the URL should NOT finish with '/'
*/

#define kCRAPIEndpointImagesSearch @"images/search"
#define kCRAPIEndpointImagesByID @"images/#"

/**
 `CRAPIRequest` contains API Request details
 */
@interface CRAPIRequest : NSObject

/**
 NSString The requestByID
 */
@property (nonatomic, strong) NSString *urlParameter;

/**
 CRAPIRequestMethod The request method
 */
@property (nonatomic, assign) CRAPIRequestMethod method;

/**
 CRAPIRequestType The API request type
 */
@property (nonatomic, assign) CRAPIRequestType requestType;

/**
 NSDictionary queryString parameters
 */
@property (nonatomic, strong) NSDictionary *parameters;

/**
 BOOL completed
 */
@property (nonatomic, assign) BOOL completed;

/**
 BOOL useSecureData (use SSL connection)
 */
@property (nonatomic, assign) BOOL useSecureData;

/**
 NSArray array of Managed Errors (defined in its Model Class)
 */
@property (nonatomic, strong, readonly) NSArray *managedErrors;

/**
 Initializes a new APIRequest with the given requestType
 @param CRAPIRequestType the requestType
 @returns CRAPIRequest a new instance of CRAPIRequest
 */
- (instancetype)initWithType:(CRAPIRequestType)requestType;

/**
 Initializes a new APIRequest with the given parameters
 @param CRAPIRequestType the requestType
 @param CRAPIRequestMethod the requestMethod
 @param NSDictionary the queryString parameter dictionary
 @returns CRAPIRequest a new instance of CRAPIRequest
 */
- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters;

/**
 Initializes a new APIRequest with the given parameters
 @param CRAPIRequestType the requestType
 @param CRAPIRequestMethod the requestMethod
 @param NSDictionary the queryString parameter dictionary
 @param NSString the urlParameter that will replace the # in the URL
 @returns CRAPIRequest a new instance of CRAPIRequest
 */
- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters
                    urlParameter:(NSString*)urlParameter;

/**
 Initializes a new APIRequest with the given parameters
 @param CRAPIRequestType the requestType
 @param CRAPIRequestMethod the requestMethod
 @param NSDictionary the queryString parameter dictionary
 @param NSUInteger the objectID to be requested by the APIRequest
 @returns CRAPIRequest a new instance of CRAPIRequest
 */
- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters
                    objectID:(NSUInteger)objectID;
/**
 Retrieves a new APIRequest with the given requestType
 @param CRAPIRequestType the requestType
 @returns CRAPIRequest a new instance of CRAPIRequest
 */
+ (instancetype)requestWithType:(CRAPIRequestType)requestType;

- (NSString*)requestMethodType;

- (NSString*)description;

- (NSString*)requestUrl;

- (NSString*)getManagedErrorMessageWithStatusCode:(NSUInteger)statusCode;

- (NSString*)stubbedJSONFile;

+ (NSDictionary *)modelClassesByResourcePath;

@end
