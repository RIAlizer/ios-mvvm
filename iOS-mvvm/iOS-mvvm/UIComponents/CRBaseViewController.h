//
//  CRBaseViewController.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "DismissViewDelegate.h"

extern CGFloat const kViewHorizontalInset;
extern CGFloat const kViewVerticalInset;
extern CGFloat const kViewVerticalGap;
extern CGFloat const kViewHorizontalGap;

@interface CRBaseViewController : UIViewController<MBProgressHUDDelegate, DismissViewDelegate>

/**
 DismissViewDelegate dismissDelegate the dismissable delegate
 */
@property (nonatomic, weak) id<DismissViewDelegate> dismissDelegate;

/**
 The ActivtyViewIndicator hud
 */
@property (nonatomic, strong) MBProgressHUD *hud;

/**
 BOOL updateContraints already called
 */
@property (nonatomic, assign) BOOL didSetupViewConstraints;

///-----------------------------------------------------------
/// @name UI Creation
///-----------------------------------------------------------

- (void)setupUI;

- (void)updateUI;

- (void)updateFonts;
/**
 Updates views' constraints
 */
- (void)updateConstraints;

///-----------------------------------------------------------
/// @name ActivityIndicator methods
///-----------------------------------------------------------

/**
 Shows the UIActivityIndicatorView
 */
- (void)showActivity;

/**
 Hides the UIActivityIndicatorView
 */
- (void)hideActivity;

///-----------------------------------------------------------
/// @name DismissViewDelegate
///-----------------------------------------------------------

/**
 Dismiss the viewController calling its dismissDelegate (if exists)
 */
- (void)dismissSelf;

/**
 Calls popViewControllerAnimated if the viewController is included in a NavigationController, calls dismissSelf if not
 */
- (void)back;

@end
