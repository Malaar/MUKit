//
//  MUPopoverController.m
//  TimeLink
//
//  Created by Malaar on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUPopoverController.h"
#import "MUPopoverViewController.h"

@implementation MUPopoverController

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithContentViewController:(UIViewController *)viewController
{
    if( (self = [super initWithContentViewController:viewController]) )
    {
        if([viewController isKindOfClass:[MUPopoverViewController class]])
        {
            [(MUPopoverViewController*)viewController setPopoverOwner:self];
        }
//        weakRef = [[MUWeakRef alloc] initWithObject:self];
    }
    return self;
}

////==============================================================================
//- (void) dealloc
//{
//    [weakRef invalidate];
//    [weakRef release];
//    
//    [super dealloc];
//}

////==============================================================================
//- (MUWeakRef*) weakReference
//{
//    return weakRef;
//}

@end
