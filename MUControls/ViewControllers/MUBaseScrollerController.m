//
//  MUTLBaseScrollerController.m
//  MUKit
//
//  Created by Yuriy Bosov on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUBaseScrollerController.h"


@implementation MUBaseScrollerController

//==============================================================================
- (id)init
{
    self = [super init];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)loadView
{
    [super loadView];
    
    // scroll view 
    Class scrollClass = [self scrollViewClass];
    
    if (!scrollView)
    {
        scrollView = [[[scrollClass alloc] init] autorelease];    
        scrollView.frame = self.view.bounds;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:scrollView];
    }
    
    // bg image for scrollview
    UIImage* bgImage = [self backgraundImageForScrollView];
    if (bgImage)
    {
        CGRect frame = self.view.bounds;
        UIImageView *backgroundView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        [backgroundView setContentMode:UIViewContentModeTop];
        [backgroundView setImage:bgImage];
        [scrollView addSubview:backgroundView];
    }
}

//==============================================================================
- (void) viewDidUnload
{
    scrollView = nil;
    [super viewDidUnload];
}

//==============================================================================
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    scrollView.contentSize = [self getContentSizeForScrollView];
}

#pragma mark - ScrollView
//==============================================================================
- (Class) scrollViewClass
{
    return [UIScrollView class];
}

//==============================================================================
- (CGSize) getContentSizeForScrollView
{
    // По умолчанию ContentSize равен размеру scrollView.
    // Переопределить в наследниках (если нужно)
    return scrollView.frame.size;
}

//==============================================================================
- (UIImage*) backgraundImageForScrollView
{
    return nil;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
