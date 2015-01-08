//
//  CRListViewController.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRListViewController.h"

@interface CRListViewController ()

@property (nonatomic, strong) UILabel *labelBeta;
@property (nonatomic, strong) UIButton *buttonCTA;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CRListViewController

#pragma mark - Init

- (instancetype)initWithViewModel:(CRListViewModel*)viewModel
{
    self = [super init];
    if (self)
    {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - View Lifecycle (load)

- (void)loadView
{
    [super loadView];
    [self setupUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UI Methods

- (void)setupUI
{
    [super setupUI];
    

    
    [self updateConstraints];
}

- (void)updateUI
{
    [super updateUI];
}

- (void)updateConstraints
{
    if (!self.didSetupViewConstraints)
    {
        [super updateConstraints];
        
  

    }
}

#pragma mark - Actions

- (void)buttonCTApressed:(id)sender
{
    DDLogVerbose(@"ok");
}

@end
