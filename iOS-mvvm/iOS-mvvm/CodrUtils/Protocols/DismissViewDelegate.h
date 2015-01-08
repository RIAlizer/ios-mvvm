//
//  DismissViewDelegate.h
//  Codr Ltd
//
//  Created by Andrea Gonteri on 24/09/2014.
//  Copyright (c) 2014 Codr Ltd Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 Implement DismissViewDelegate in order to intercept dimissed ViewControllers
 */
@protocol DismissViewDelegate <NSObject>

- (void)didDismissModalView:(id)sender;

@end
