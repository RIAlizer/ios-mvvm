//
//  CRMainViewController.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRMainViewController.h"

#import "CRListViewController.h"
#import "CRListViewModel.h"

@interface CRMainViewController ()

@property (nonatomic, strong) UILabel *labelBeta;
@property (nonatomic, strong) UIButton *buttonCTA;

@end

@implementation CRMainViewController

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
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
    
    //labelBeta
    self.labelBeta = [UILabel newAutoLayoutView];
    self.labelBeta.textAlignment = NSTextAlignmentCenter;
    NSString *nameKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    NSString *shortString = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    self.labelBeta.text = [NSString stringWithFormat: @"%@\n Version: %@", nameKey, shortString];
    self.labelBeta.numberOfLines = 0;
    [self.view addSubview:self.labelBeta];
    
    //buttonCTA
    self.buttonCTA = [UIButton newAutoLayoutView];
    self.buttonCTA.backgroundColor = [UIColor lightGrayColor];
    [self.buttonCTA setTitle:LSTR(@"Search") forState:UIControlStateNormal];
    [self.buttonCTA addTarget:self action:@selector(buttonCTApressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonCTA];
    
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
        
        //labelBeta
        [self.labelBeta autoSetDimension:ALDimensionHeight toSize:44];
        [self.labelBeta autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kViewHorizontalInset];
        [self.labelBeta autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kViewHorizontalInset];
        [self.labelBeta autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        
        //buttonCTA
        [self.buttonCTA autoSetDimension:ALDimensionHeight toSize:44];
        [self.buttonCTA autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kViewHorizontalInset];
        [self.buttonCTA autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kViewHorizontalInset];
        [self.buttonCTA autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.labelBeta withOffset:kViewVerticalGap];

    }
}

#pragma mark - Actions

- (void)buttonCTApressed:(id)sender
{
    CRListViewModel *viewModel = [[CRListViewModel alloc] initWithQuery:@"sample"];
    CRListViewController *viewController = [[CRListViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
