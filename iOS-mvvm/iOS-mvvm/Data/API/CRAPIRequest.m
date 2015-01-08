//
//  IWAPIRequest.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRAPIRequest.h"

NSString * const kCRErrorCode = @"kCRErrorCode";
NSString * const kCRErrorMessage = @"kCRErrorMessage";

NSString * const kCRMapperEndpointKey = @"kCRMapperEndpointKey";
NSString * const kCRMapperClass = @"kCRMapperClass";

NSString * const kCRMapperStubbedGET = @"kCRMapperStubbedGET";
NSString * const kCRMapperStubbedLIST = @"kCRMapperStubbedLIST";
NSString * const kCRMapperStubbedPOST = @"kCRMapperStubbedPOST";
NSString * const kCRMapperStubbedDELETE = @"kCRMapperStubbedDELETE";
NSString * const kCRMapperStubbedPUT = @"kCRMapperStubbedPUT";
NSString * const kCRMapperStubbedPATCH = @"kCRMapperStubbedPATCH";

NSString * const kCRMapperRequestType = @"kCRMapperRequestType";

@implementation CRAPIRequest

#pragma mark - Init

- (instancetype)initWithType:(CRAPIRequestType)requestType
{
    self = [super init];
    if (self)
    {
        _method = CRAPIRequestMethodLIST;
        _parameters = nil;
        _requestType = requestType;
        _completed = NO;
        _useSecureData = NO;
        _urlParameter = nil;
    }
    return self;
}

- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters
{
    self = [self initWithType:requestType];
    if (self)
    {
        _method = method;
        _parameters = parameters;
    }
    return self;
}

- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters
                    objectID:(NSUInteger)objectID
{
    self = [self initWithType:requestType method:method parameters:parameters];
    if (self)
    {
        _urlParameter = [NSString stringWithFormat:@"%@",@(objectID)];
    }
    return self;
}

- (instancetype)initWithType:(CRAPIRequestType)requestType
                      method:(CRAPIRequestMethod)method
                  parameters:(NSDictionary*)parameters
                urlParameter:(NSString *)urlParameter
{
    self = [self initWithType:requestType method:method parameters:parameters];
    if (self)
    {
        _urlParameter = urlParameter;
    }
    return self;
}

+ (instancetype)requestWithType:(CRAPIRequestType)requestType
{
    CRAPIRequest *request = [[CRAPIRequest alloc] init];
    request.requestType = requestType;
    
    return request;
}

- (NSString*)requestUrl
{
    NSString *url = [self requestUrlByType];
    NSAssert(url.length > 0, @"Undefined request endpoint for request type %ld", self.requestType);
    
    if(IsEmpty(self.urlParameter))
    {
        return url;
    }
    NSString *urlWithParameter;
    
    if([url containsString:@"#"] || [url containsString:@"*"])
    {
        urlWithParameter = url;
    }
    else
    {
        urlWithParameter = [NSString stringWithFormat:@"%@/#", url];
    }
    
    NSString *stringFormat;
    stringFormat = [urlWithParameter stringByReplacingOccurrencesOfString:@"#" withString:@"%@"];
    
    NSString *path = [NSString stringWithFormat:stringFormat, self.urlParameter];
    return path;
}

- (NSString*)requestUrlByType
{
    NSString *urlString = [CRAPIRequest serviceMapping][@(self.requestType)][kCRMapperEndpointKey];
    
    NSAssert(urlString.length > 0, @"Undefined request endpoint for request type %ld", self.requestType);
    
    return urlString;
}

- (NSString*)requestMethodType
{
    switch (self.method)
    {
        case CRAPIRequestMethodGET:
        case CRAPIRequestMethodLIST:
            return @"GET";
        case CRAPIRequestMethodHEAD:
            return @"HEAD";
        case CRAPIRequestMethodPUT:
            return @"PUT";
        case CRAPIRequestMethodPOST:
            return @"POST";
        case CRAPIRequestMethodPATCH:
            return @"PATCH";
        case CRAPIRequestMethodDELETE:
            return @"DELETE";
    }
    return @"";
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"[%@] %@", [self requestMethodType], self.requestUrl];
}

- (NSString*)getManagedErrorMessageWithStatusCode:(NSUInteger)statusCode
{
    NSString *message;
    //check model's managedErrors
    message = [self getManagedErrorMessageWithStatusCode:statusCode fromList:self.managedErrors];
    if(IsEmpty(message))
    {
        //check CRAPIRequest defaultManagedErrors
        message = [self getManagedErrorMessageWithStatusCode:statusCode fromList:[CRAPIRequest defaultManagedErrors]];
    }
    return message;
}

- (NSString*)getManagedErrorMessageWithStatusCode:(NSUInteger)statusCode fromList:(NSArray*)errorList
{
    for (NSDictionary *error in errorList)
    {
        if([error[kCRErrorCode] integerValue] == statusCode)
        {
            return error[kCRErrorMessage];
        }
    }
    return nil;
}

+ (NSArray *)defaultManagedErrors
{
    return @[@{kCRErrorCode : @401, kCRErrorMessage: LSTR(@"CRAPIRequest GenericError 401", @"Not authenticated")},
             @{kCRErrorCode : @403, kCRErrorMessage: LSTR(@"CRAPIRequest GenericError 403", @"Not authorised")},
             @{kCRErrorCode : @404, kCRErrorMessage: LSTR(@"CRAPIRequest GenericError 404", @"Resource Not Found")},
             @{kCRErrorCode : @500, kCRErrorMessage: LSTR(@"CRAPIRequest GenericError 500", @"Internal Server Error")},
             @{kCRErrorCode : @503, kCRErrorMessage: LSTR(@"CRAPIRequest GenericError 503", @"Error on a third party service")},
             ];
}

- (NSArray*)managedErrors
{
//    Class errorClass = [CRAPIRequest serviceMapping][@(self.requestType)][kCRMapperClass];
//    NSArray *errors = [errorClass managedErrorsByRequestMethod:self.method];
    return @[];
}

/**
 Overcoat serviceMapping
 */
+ (NSDictionary *)modelClassesByResourcePath
{
    NSDictionary *serviceMapping = [CRAPIRequest serviceMapping];
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [serviceMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *endpointKey = [obj objectForKey:kCRMapperEndpointKey];
        Class modelClass = [obj objectForKey:kCRMapperClass];
        [dictionary setValue:modelClass forKey:endpointKey];
    }];
    
    return dictionary;
    
    /**
     OVCHTTPSessionManager modelClassesByResourcePath needs a NSDictionary with URL as key and Response Class as value
     ie:   return @{kCRAPIEndpointTrainers : [IWTrainer class],};
     */
}

/**
 Iwoo serviceMapping
*/
+ (NSDictionary *)serviceMapping
{
    return @{
             @(CRAPIRequestTypeImagesSearch):
                 @{kCRMapperEndpointKey: kCRAPIEndpointImagesSearch,
                   kCRMapperClass: [CRShutterStockImage class],
                   kCRMapperStubbedGET: @"iwtrainerGET.json",
                   kCRMapperStubbedLIST: @"iwtrainerLIST.json",
                   
                   },
             /*
             //CRAPIRequestTypeTrainers
             @(CRAPIRequestTypeTrainers):
                 @{kCRMapperEndpointKey: kCRAPIEndpointTrainers,
                   kCRMapperClass: [IWTrainer class],
                   kCRMapperStubbedGET: @"iwtrainerGET.json",
                   kCRMapperStubbedLIST: @"iwtrainerLIST.json",
                   
                   },
             //CRAPIRequestTypePayments
             @(CRAPIRequestTypePayments):
                 @{kCRMapperEndpointKey:kCRAPIEndpointPayments,
                   kCRMapperClass:[IWPayment class],
                   kCRMapperStubbedPOST: @"iwpaymentPOST.json"
                   },
             //CRAPIRequestTypeBooking
             @(CRAPIRequestTypeBooking):
                 @{kCRMapperEndpointKey:kCRAPIEndpointBooking,
                   kCRMapperClass:[IWSession class],
                   kCRMapperStubbedGET: @"iwsessionGET.json",
                   kCRMapperStubbedPOST: @"iwsessionPOST_PENDING.json",
                   kCRMapperStubbedPATCH: @"iwsessionGET_PAST_SESSION.json",
                   kCRMapperStubbedDELETE: @"iwsessionDELETE.json",
                   },
             //CRAPIRequestTypeBookingByUserID
             @(CRAPIRequestTypeBookingByUserID):
                 @{kCRMapperEndpointKey:kCRAPIEndpointBookingByUserID,
                   kCRMapperClass:[IWSession class],
                   kCRMapperStubbedLIST: @"iwsessionLIST.json",
                   },
             //CRAPIRequestTypeUsersRegistration
             @(CRAPIRequestTypeUsersRegistration):
                 @{kCRMapperEndpointKey:kCRAPIEndpointUsers,
                   kCRMapperClass:[IWUser class],
                   kCRMapperStubbedPOST: @"iwuserPOST_ACTIVE_registration.json"
                   },
             //CRAPIRequestTypeUsersAuthentication
             @(CRAPIRequestTypeUsersAuthentication):
                 @{kCRMapperEndpointKey:kCRAPIEndpointUsersAuthenticate,
                   kCRMapperClass:[IWCurrentUser class],
                   kCRMapperStubbedPOST: @"iwuserPOST_ACTIVE.json"
                   },
             //CRAPIRequestTypePaymentMethods
             @(CRAPIRequestTypePaymentMethods):
                 @{kCRMapperEndpointKey:kCRAPIEndpointPaymentMethods,
                   kCRMapperClass:[IWPaymentMethod class],
                   kCRMapperStubbedLIST: @"iwpayment-methodsLIST.json"
                   },
             //
             @(CRAPIRequestTypePromocodes):
                 @{kCRMapperEndpointKey:kCRAPIEndpointPromocodes,
                   kCRMapperClass:[IWPromocode class],
                   kCRMapperStubbedGET: @"iwpromocodeGET.json"
                   },
             */
             };
}

- (NSString*)stubbedJSONFileKey
{
    switch (self.method)
    {
        case CRAPIRequestMethodGET:
            return kCRMapperStubbedGET;
        case CRAPIRequestMethodLIST:
            return kCRMapperStubbedLIST;
        case CRAPIRequestMethodPOST:
            return kCRMapperStubbedPOST;
        case CRAPIRequestMethodDELETE:
            return kCRMapperStubbedDELETE;
        case CRAPIRequestMethodPATCH:
            return kCRMapperStubbedPATCH;
        default:
            return nil;
    }
    return nil;
}

- (NSString*)stubbedJSONFile
{
    NSString *urlString;
    NSString *stubbedKey = [self stubbedJSONFileKey];
    if(stubbedKey)
    {
        urlString = [CRAPIRequest serviceMapping][@(self.requestType)][stubbedKey];
        NSAssert(urlString, @"stubbedJSONFile not provided");
    }
    return urlString;
}

@end
