//
//  MUSwitchController.m
//  MUKitTest
//
//  Created by Malaar on 06.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSwitchController.h"

@implementation MUSwitchController

@synthesize switchDelegate;

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        self.navigationBarHidden = YES;
    }
    return self;
}

//==============================================================================
- (void) switchToController:(UIViewController*)aController
{
    BOOL canSwitch = YES;
    if([switchDelegate respondsToSelector:@selector(switchController:shouldSwitchToController:)])
        canSwitch = [switchDelegate switchController:self shouldSwitchToController:aController];

    if(canSwitch)
    {
        if([switchDelegate respondsToSelector:@selector(switchController:willSwitchToController:)])
            [switchDelegate switchController:self willSwitchToController:aController];

        [self setViewControllers:[NSArray arrayWithObject:aController] animated:NO];

        if([switchDelegate respondsToSelector:@selector(switchController:didSwitchToController:)])
            [switchDelegate switchController:self didSwitchToController:aController];
    }
}

#pragma mark - Disabled methods
//==============================================================================
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    [self release];
    return nil;
}

//==============================================================================
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSAssert(NO, @"You can't use this method!");
}

//==============================================================================
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    NSAssert(NO, @"You can't use this method!");
    return nil;
}

//==============================================================================
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSAssert(NO, @"You can't use this method!");
    return nil;
}

//==============================================================================
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSAssert(NO, @"You can't use this method!");
    return nil;
}

@end
