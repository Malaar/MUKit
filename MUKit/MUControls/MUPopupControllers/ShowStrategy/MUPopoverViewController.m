//
//  MUPopoverViewController.m
//  MUKit
//
//  Created by Malaar on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUPopoverViewController.h"

@implementation MUPopoverViewController

@synthesize popoverOwner;

//==============================================================================
- (id) initWithPopupView:(MUPopupView*)aPopupedView
{
    if( (self = [super init]) )
    {
        popupedView = [aPopupedView retain];
        self.modalInPopover = !popupedView.hideByTapOutside;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [popupedView release];
    
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.bounds = popupedView.bounds;

    popupedView.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:popupedView];

    [self setContentSizeForViewInPopover:popupedView.bounds.size];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [popupedView popupWillAppear:animated];
}

//==============================================================================
- (void) viewDidAppear:(BOOL)animated
{
    [popupedView popupDidAppear:animated];
}

//==============================================================================
- (void) viewWillDisappear:(BOOL)animated
{
    [popupedView popupWillDisappear:animated];
}

//==============================================================================
- (void) viewDidDisappear:(BOOL)animated
{
    [popupedView popupDidDisappear:animated];
    
    [popoverOwner autorelease];
}

@end
