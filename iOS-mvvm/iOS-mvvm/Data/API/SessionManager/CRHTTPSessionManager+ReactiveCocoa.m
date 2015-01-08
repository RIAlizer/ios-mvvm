//  CRHTTPSessionManager+ReactiveCocoa.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//
// Cloned by ReactiveCocoa+Overcoat
// more info https://github.com/gonzalezreal/Overcoat/tree/master/ReactiveCocoa%2BOvercoat

#import "CRHTTPSessionManager+ReactiveCocoa.h"
#import "NSError+OVCResponse.h"

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)

@implementation CRHTTPSessionManager (ReactiveCocoa)

- (NSError*)managedErrorWithResponseError:(NSError*)responseError
{
    return responseError;
}

- (RACSignal *)executeRequest:(CRAPIRequest *)apiRequest
{
    NSParameterAssert(apiRequest);
    self.apiRequest = apiRequest;
    //set options
    [self setSessionManagerOptionsforRequest:apiRequest];
    

#if DEBUG_USING_STUB_REQUEST
    
    [self forceUseStubRequest];
    
#endif

    return [self iw_performRequest];
}

- (RACSignal*)iw_performRequest
{
    CRAPIRequest* apiRequest = self.apiRequest;
    
    switch (apiRequest.method)
    {
        case CRAPIRequestMethodGET:
        {
            return [self rac_GET:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodLIST:
        {
            return [self rac_GET:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodPUT:
        {
            return [self rac_PUT:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodPOST:
        {
            return [self rac_POST:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodPATCH:
        {
            return [self rac_PATCH:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodDELETE:
        {
            return [self rac_DELETE:apiRequest.requestUrl parameters:apiRequest.parameters];
        }
        case CRAPIRequestMethodHEAD:
        {
            DDLogInfo(@"to be implemented");
            break;
        }
        default:
            
            break;
    }
    return nil;
}


#pragma mark - ReactiveCocoa+Overcoat Cloned

/**
 Enqueues a `GET` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_GET:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        __block NSURLSessionDataTask *task = [self GET:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, URLString, parameters];
}

/**
 Enqueues a `HEAD` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_HEAD:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self HEAD:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_HEAD: %@, parameters: %@", self.class, URLString, parameters];
}

/**
 Enqueues a `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_POST:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self POST:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@", self.class, URLString, parameters];
}

/**
 Enqueues a multipart `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param block A block that takes a single argument and appends data to the HTTP body. The block
 argument is an object adopting the `AFMultipartFormData` protocol.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_POST:(NSString *)URLString parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self POST:URLString parameters:parameters constructingBodyWithBlock:block completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, constructingBodyWithBlock", self.class, URLString, parameters];
}

/**
 Enqueues a `PUT` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_PUT:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self PUT:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_PUT: %@, parameters: %@", self.class, URLString, parameters];
}

/**
 Enqueues a `PATCH` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self PATCH:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_PATCH: %@, parameters: %@", self.class, URLString, parameters];
}

/**
 Enqueues a `DELETE` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 
 @return A cold signal which sends a `OVCResponse` on next event and completes, or error otherwise
 */
- (RACSignal *)rac_DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block NSURLSessionDataTask *task = [self DELETE:URLString parameters:parameters completion:^(id response, NSError *error) {
            if (!error) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            } else {
                NSError *managedError = [self managedErrorWithResponseError:error];
                [subscriber sendError:managedError];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_DELETE: %@, parameters: %@", self.class, URLString, parameters];
}

@end

#endif
