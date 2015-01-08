//
//  CRHTTPSessionManager.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRHTTPSessionManager.h"
#import <AFNetworking/AFNetworking.h>
#import "CRAPIRequest.h"

//#import "OHHTTPStubs.h"

static CRHTTPSessionManager *_sharedInstance = nil;

@interface CRHTTPSessionManager ()
{

}
@end

#pragma mark - CRHTTPSessionManager implementation

@implementation CRHTTPSessionManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:CRHTTPSessionManager.baseURLString];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setTimeoutIntervalForRequest:kCRAPITimeoutIntervalForRequest];
        
        _sharedInstance = [[CRHTTPSessionManager alloc]
                           initWithBaseURL:baseURL
                           sessionConfiguration:sessionConfiguration];
        
        //requestSerializer should be AFJSONRequestSerializer
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedInstance.requestSerializer.timeoutInterval = kCRAPITimeoutIntervalForRequest;
        
        //basic authentication
        [_sharedInstance.requestSerializer setAuthorizationHeaderFieldWithUsername:kCRAPIClientID password:kCRAPIClientSecret];
        
    });
    
    return _sharedInstance;
}

+ (NSString*)baseURLString
{
    return [NSString stringWithFormat:@"%@/%@/", kCRShutterStockAPIBaseURL, kCRShutterStockAPIVersion]; ;
}

#pragma mark - Public

- (void)setSessionManagerOptionsforRequest:(CRAPIRequest*)apiRequest
{
    self.securityPolicy = [AFSecurityPolicy defaultPolicy];
}

- (void)forceUseStubRequest
{
    //if Test stub request is managed by the test itself
#ifdef IW_TEST
    return;
#endif
    
//    [OHHTTPStubs removeAllStubs];
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        BOOL forceStub = [request.URL.host containsString:kCRiWooAPIBaseStagingAPIDomain];
//        return forceStub;
//    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//        // Stub it!
//        NSString *stubbedJSONFile = self.apiRequest.stubbedJSONFile;
//        int statusCode = 200;
//        NSString *filePath = OHPathForFileInBundle(stubbedJSONFile,nil);
//        DDLogVerbose(@"stubbedJSONFile: %@", stubbedJSONFile);
//        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//        {
//         //added thread sleep timer to simulate network request
//            [NSThread sleepForTimeInterval:CRAPIRequest_STUB_FAKE_TIMEOUT_SLEEP];
//            
//            return [OHHTTPStubsResponse
//                    responseWithFileAtPath:filePath
//                    statusCode:statusCode
//                    headers:@{@"Content-Type":@"text/json"}];
//        }
//        else
//        {
//            return [OHHTTPStubsResponse responseWithError:[NSError customErrorWithMessage:[NSString stringWithFormat:@"StubbedJSONFile not exist (%@)", stubbedJSONFile]]];
//        }
//    }];
}

#pragma mark - Overcoat overridings
//The Error Class used by Overcoat to map errors (managed by the API)
+ (Class)errorModelClass
{
    return nil;
}

+ (NSDictionary *)modelClassesByResourcePath
{
    return [CRAPIRequest modelClassesByResourcePath];
}

@end
