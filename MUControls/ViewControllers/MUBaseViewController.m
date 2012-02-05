//
//  MUBaseViewController.m
//  MUKit
//
//  Created by Malaar on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUBaseViewController.h"
#import "MUSpinneredView.h"

@implementation MUBaseViewController

#pragma mark - init/dealoc
//==============================================================================
- (void)dealloc
{
    [spinneredView release];    
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)loadView
{
    [super loadView];

    // create spinnered view
    spinneredView = [[MUSpinneredView alloc] initWithParentView:self.view color:[UIColor colorWithRed:28.0f/255.0f green:28.0f/255.0f blue:28.0f/255.0f alpha:128.0f/255.0f]];

    // bg image
    UIImage* bgImage = [self backgraundImage];
    if (bgImage)
    {
        CGRect frame = self.view.bounds;
        UIImageView *backgroundView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        [backgroundView setContentMode:UIViewContentModeTop];
        [backgroundView setImage:bgImage];
        [self.view addSubview:backgroundView];
    }

    // left nav button
    if(!self.navigationItem.hidesBackButton)
    {
        // custom left button
        UIBarButtonItem* leftNavigationButton = [self createLeftNavButton];
        if(leftNavigationButton)
        {
            if ([leftNavigationButton.customView isKindOfClass:[UIButton class]])
            {
                [((UIButton*)leftNavigationButton.customView) addTarget:self action:@selector(leftNavButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                leftNavigationButton.target = self;
                leftNavigationButton.action = @selector(leftNavButtonPressed:);
            }
            self.navigationItem.leftBarButtonItem = leftNavigationButton;
        }
    }

    // right nav button
    UIBarButtonItem* rightNavigationButton = [self createRightNavButton];
    if(rightNavigationButton)
    {
        if ([rightNavigationButton.customView isKindOfClass:[UIButton class]])
        {
            [((UIButton*)rightNavigationButton.customView) addTarget:self action:@selector(rightNavButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            rightNavigationButton.target = self;
            rightNavigationButton.action = @selector(rightNavButtonPressed:);
        }
        self.navigationItem.rightBarButtonItem = rightNavigationButton;
    }
    
    // custon title view for nav.item
    UIView *titleView = [self titleViewNavItem];
    if (titleView)
    {
        self.navigationItem.titleView = titleView;
    }
}

//==============================================================================
- (void)viewDidUnload
{
    [spinneredView release];
    spinneredView = nil;
    
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    isVisible = YES;
}

//==============================================================================
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    isVisible = NO;
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ? (YES) : (NO);
}


#pragma mark - Spinnered View
//==============================================================================
// show spinnered view above
- (void) showSpinneredView
{
    [spinneredView show];
}

//==============================================================================
// hide spinnered view
- (void) hideSpinneredView;
{
    [spinneredView hide];
}

#pragma mark - Show Alert View
//==============================================================================
- (void)showAlertViewWithTitle:(NSString *)aTitle message:(NSString *)aMessage delegate:(id)aDelegate cancelButtonTitle:(NSString *)aCancelButtonTitle otherButtonTitle:(NSString *)aOtherButtonTitle
{
    if (isVisible)
    {
        [[[[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:aDelegate cancelButtonTitle:aCancelButtonTitle otherButtonTitles:aOtherButtonTitle, nil] autorelease] show];
    }
}

#pragma mark - Customization For Navigation Bar
//==============================================================================
// create custom left button for navigation bar
- (UIBarButtonItem*) createLeftNavButton
{
    return nil;
}

//==============================================================================
// create custom right button for navigation bar
- (UIBarButtonItem*) createRightNavButton
{
    return nil;
}

//==============================================================================
// create custom title view for navigation bar (return nil by default)
- (UIView*) titleViewNavItem
{
    return nil;
}

#pragma mark - Process Events
//==============================================================================
// action to process pressed-on-left-button event
- (void) leftNavButtonPressed:(id)aSender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//==============================================================================
// action to process pressed-on-right-button event
- (void) rightNavButtonPressed:(id)aSender
{
    // empty by default
}

#pragma mark - Backgraung Image
//==============================================================================
- (UIImage*) backgraundImage
{
    // default nil
    return nil;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
