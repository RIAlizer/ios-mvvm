//
//  CRListViewModel.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "RVMViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Overcoat/ReactiveCocoa+Overcoat.h>
#import <Overcoat/Overcoat.h>

@class RACCommand;

@interface CRListViewModel : RVMViewModel

@property (nonatomic, strong) NSString *query;

@property (nonatomic, strong) NSError *fetchCommandError;

@property (nonatomic, strong) RACCommand *fetchCommand;

- (instancetype)initWithQuery:(NSString*)query NS_DESIGNATED_INITIALIZER;

@end
