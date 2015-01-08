//
//  CRListViewModel.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRListViewModel.h"
#import "CRHTTPSessionManager.h"
#import "CRHTTPSessionManager+ReactiveCocoa.h"
#import "CRAPIRequest.h"

@interface CRListViewModel()

@end

@implementation CRListViewModel

#pragma mark - Initalization

- (instancetype)initWithQuery:(NSString*)query
{
    self = [super init];
    if (self)
    {
        _query = query;
        [self bindInternalSignals];
    }
    
    return self;
}

#pragma mark - Properties


#pragma mark - Private

- (void)bindInternalSignals
{

}


#pragma mark - Private

- (RACSignal *)fetchCommandSignal
{
    CRHTTPSessionManager *sessionManger = [CRHTTPSessionManager sharedInstance];
    CRAPIRequest *apiRequest = [[CRAPIRequest alloc]
                                initWithType:CRAPIRequestTypeImagesSearch
                                method:CRAPIRequestMethodLIST
                                parameters:nil];
    
    
    RACSignal *commandSignal = [sessionManger executeRequest:apiRequest];
    return commandSignal;
}

@end
