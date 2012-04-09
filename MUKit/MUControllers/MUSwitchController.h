//
//  MUSwitchController.h
//  MUKitTest
//
//  Created by Malaar on 06.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUSwitchController;

@protocol MUSwitchControllerDelegate <NSObject>

- (BOOL) switchController:(MUSwitchController*)aSwitchController shouldSwitchToController:(UIViewController*)aController;
- (void) switchController:(MUSwitchController*)aSwitchController willSwitchToController:(UIViewController*)aController;
- (void) switchController:(MUSwitchController*)aSwitchController didSwitchToController:(UIViewController*)aController;

@end


@interface MUSwitchController : UINavigationController

@property (nonatomic, assign) id<MUSwitchControllerDelegate> switchDelegate;

- (void) switchToController:(UIViewController*)aController animated:(BOOL)anAnimate;

@end
