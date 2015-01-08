//
//  CRListViewController.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRBaseViewController.h"
#import "CRListViewModel.h"

@interface CRListViewController : CRBaseViewController

@property (nonatomic, strong) CRListViewModel *viewModel;

- (instancetype)initWithViewModel:(CRListViewModel*)viewModel NS_DESIGNATED_INITIALIZER;

@end
