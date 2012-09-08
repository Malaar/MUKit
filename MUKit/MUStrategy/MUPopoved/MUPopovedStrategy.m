//
//  MUPopovedStrategy.m
//  MUKit
//
//  Created by Malaar on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUPopovedStrategy.h"


@interface MUPopovedStrategy ()

- (UIPopoverController*) popoverControllerWithContent:(UIViewController*)aController;

@end

@implementation MUPopovedStrategy

@synthesize popoverBackgroundViewClass;
@synthesize popovedView;
@synthesize popoverController;
@synthesize permittedArrowDirections;

//==============================================================================
- (void) dealloc
{
    [popovedView release];
    [popoverController release];
    
    [super dealloc];
}

//==============================================================================
- (void) presentPopoverFromView:(UIView*)aView
            withContentController:(UIViewController<MUPopoverable>*)aPopoverableController
         permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                         animated:(BOOL)animated
{
    popovedView = [aView retain];
    permittedArrowDirections = arrowDirections;
    popoverController = [[self popoverControllerWithContent:aPopoverableController] retain];
    aPopoverableController.popover = self.popoverController;

    [self.popoverController presentPopoverFromRect:popovedView.bounds
                                            inView:popovedView
                          permittedArrowDirections:permittedArrowDirections
                                          animated:animated];
}

//==============================================================================
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(popoverController.isPopoverVisible)
    {
        [popoverController dismissPopoverAnimated:NO];
    
        [popoverController presentPopoverFromRect:popovedView.bounds
                                           inView:popovedView
                         permittedArrowDirections:permittedArrowDirections
                                         animated:NO];
    }
}

#pragma mark - Private
//==============================================================================
- (UIPopoverController*) popoverControllerWithContent:(UIViewController*)aController
{
    if(!popoverController)
    {
        popoverController = [[[UIPopoverController alloc] initWithContentViewController:aController] autorelease];
        if(popoverBackgroundViewClass)
            [popoverController setPopoverBackgroundViewClass:popoverBackgroundViewClass];
    }
    else
    {
        [popoverController setContentViewController:aController];
        [popoverController setPopoverContentSize:aController.contentSizeForViewInPopover];
    }
    
    return popoverController;
}

@end
