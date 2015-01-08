//
//  CRBaseViewController.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRBaseViewController.h"

#pragma mark - Constants

CGFloat const kViewHorizontalInset = 22.0f;
CGFloat const kViewVerticalInset = 16.0f;
CGFloat const kViewVerticalGap = 5.0f;
CGFloat const kViewHorizontalGap = 5.0f;

@interface CRBaseViewController ()
{
    NSString *_defaultHudMessage;
    NSString *_defaultHudDetailedMessage;
    MBProgressHUDMode _defaultHudProgressMode;
}

@end

@implementation CRBaseViewController

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultHudMessage = LSTR(@"Loading");
        _defaultHudDetailedMessage = LSTR(@"Retrieving data");
        _defaultHudProgressMode = MBProgressHUDModeIndeterminate;
    }
    return self;
}

#pragma mark - Memory Management

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle (load)

- (void)loadView
{
    //debug purpouse
    self.navigationItem.title = NSStringFromClass([self class]);
    
    [super loadView];
}

#pragma mark - UI Methods

- (void)setupUI
{
    
}

- (void)updateUI
{
    
}

- (void)updateFonts
{
    
}

- (void)updateConstraints
{
    if(!self.didSetupViewConstraints)
    {
        self.didSetupViewConstraints = YES;
        
    }
}

- (void)showActivity
{
    dev_runOnMainQueueWithoutDeadlocking(^{
        
        [self showActivityWithMessage:_defaultHudMessage
                  withDetailedMessage:_defaultHudDetailedMessage
                      andProgressMode:_defaultHudProgressMode];
        
    });
}

- (void)showActivityWithMessage:(NSString *)inputText withDetailedMessage:(NSString *)inputDetailedText andProgressMode:(MBProgressHUDMode)inputHUDMode
{
    BOOL disableProgressHUD = NO;
#if DISABLE_MBPROGRESS_HUD
    disableProgressHUD = YES;
#endif
    
    if(disableProgressHUD)
        return;
    
    if (self.hud!=nil)
    {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.animationType = MBProgressHUDAnimationFade;
    [self.view addSubview:self.hud ];
    [self.view  bringSubviewToFront:self.hud ];
    
    // Set mode
    self.hud.mode = inputHUDMode;
    
    // self.hud.dimBackground = YES;
    self.hud.delegate = self;
    self.hud.labelText = inputText;    
    [self.view bringSubviewToFront:self.hud];
}

- (void)hideActivity
{
    if(self.hud)
    {
        dev_runOnMainQueueWithoutDeadlocking(^{
            [self.hud hide:YES];
        });
    }
}

#pragma mark - MBProgressHUDDelegate implementation

- (void)hudWasHidden
{
    // Remove HUD from screen when the HUD was hidded
    if(_hud)
    {
        [_hud removeFromSuperview];
    }
}

#pragma mark - DismissViewDelegate utils

- (void)dismissSelf
{
    if (self.dismissDelegate != nil)
    {
        [self.dismissDelegate didDismissModalView:self];
    }
    //if is still presented
    if(self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }
}

- (void)back
{
    if(self.navigationController!=nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        if (self.dismissDelegate != nil)
        {
            [self.dismissDelegate didDismissModalView:self];
            
        }
    }
    else
    {
        DDLogVerbose(@"back: self.navigationController is NIL");
        [self dismissSelf];
    }
}

#pragma mark - DismissViewDelegate implementation

- (void)didDismissModalView:(id)sender
{
    
}

#pragma mark - UIStatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
