//
//  MUPopupView.m
//  MUKit
//
//  Created by Malaar on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUPopupView.h"
#import "MUPopoverViewController.h"
#import "MUKitDefines.h"


@implementation MUPopupView

@synthesize showStrategy;
@synthesize hideByTapOutside;
@synthesize showOverlayView;
@synthesize isVisible;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if( (self = [super initWithCoder:aDecoder]) )
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (id) initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
	[weakRef invalidate];
	[weakRef release];
	
	[super dealloc];
}

//==============================================================================
- (void) setup
{
    weakRef = [[MUWeakRef alloc] initWithObject:self];

    hideByTapOutside = YES;
}

//==============================================================================
- (void) prepareToRelease
{
    if([showStrategy isKindOfClass:[MUPopupViewController class]])
    {
        [(MUPopupViewController*)showStrategy release];
    }
}

//==============================================================================
- (void) prepareToShow
{
    [showStrategy release];
    showStrategy = nil;
    
//    NSLog(@"retainCount: %i", self.retainCount);
    if(!MU_IS_IPAD)
    {
        MUPopupViewController* popupController = [[MUPopupViewController alloc] init];
        popupController.popupedView = self;
        
        showStrategy = popupController;
    }
    else
    {
        MUPopoverViewController* popoverViewController = [[MUPopoverViewController alloc] initWithPopupView:self];
        UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
        popoverViewController.popoverOwner = popoverController;
        [popoverViewController release];
        
        showStrategy = popoverController;
    }
}

//==============================================================================
- (void) popupWillAppear:(BOOL)animated
{
    isVisible = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_WILL_SHOW object:self];
}

//==============================================================================
- (void) popupDidAppear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_DID_SHOW object:self];
}

//==============================================================================
- (void) popupWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_WILL_HIDE object:self];
}

//==============================================================================
- (void) popupDidDisappear:(BOOL)animated
{
    showStrategy = nil;

    isVisible = NO;
	[[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_DID_HIDE object:self];
}

#pragma mark - weakReference
//==============================================================================
- (MUWeakRef*) weakReference
{
	return weakRef;
}

//==============================================================================
- (void) hideWithAnimation:(BOOL)animation
{
    if(!MU_IS_IPAD)
    {
        [(MUPopupViewController*)showStrategy hideWithAnimation:animation];
    }
    else
    {
        [(UIPopoverController*)showStrategy dismissPopoverAnimated:animation];
    }
    
}

//==============================================================================
- (void) showWithAnimation:(BOOL)animation inView:(UIView*)aView
{
    if(!MU_IS_IPAD)
    {
        [(MUPopupViewController*)showStrategy showWithAnimation:animation inView:aView];
    }
}

//==============================================================================
- (void)showFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
    if(MU_IS_IPAD)
    {
        [(UIPopoverController*)showStrategy presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
    }
}

////==============================================================================
//- (void) setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    if([showStrategy isKindOfClass:[UIPopoverController class]])
//    {
//        [((UIPopoverController*)showStrategy).contentViewController setContentSizeForViewInPopover:frame.size];
//    }
//}

@end
