//
//  MUTabBarController.m
//  MUKitTest
//
//  Created by Malaar on 07.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTabBarController.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTabBarController ()

- (CGRect) getContentFrame;
- (void) setupControllers;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTabBarController

@synthesize delegate;

@synthesize tabBarOnTheTop;
@synthesize tabBarHeight;
@synthesize tabBarBackgroundImage;
@synthesize tabBarDrawColor;
@synthesize tabBarBackgroundColor;
@synthesize tabBarButtons;
@synthesize tabBarEnabled;

@synthesize viewControllers;
@dynamic selectedViewController;
@synthesize selectedIndex;

#pragma mark - Init/Dealloc
//==============================================================================
- (id)init
{
    self = [super init];
    if (self)
    {
        tabBarHeight = 44;
        selectedIndex = 0;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [tabBarBackgroundImage release];
    [tabBarBackgroundColor release];
    [tabBarButtons release];
    
    [viewControllers release];
    
    [super dealloc];
}

#pragma mark - View Lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
}

//==============================================================================
- (void)viewDidUnload
{
    tabBar = nil;
    stackedView = nil;
    
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!stackedView)
    {
        stackedView = [[MUStackedView alloc] initWithFrame:[self getContentFrame]];
        stackedView.delegate = self;
        stackedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:stackedView];
        [stackedView release];
    }
    
    if(!tabBar)
    {
        // create tabBar
        float y = (tabBarOnTheTop) ? (0) : (self.view.bounds.size.height - tabBarHeight);
        tabBar = [[MUTabedToolbar alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, tabBarHeight)];
        tabBar.delegate = self;
        tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tabBar.backgroundImage = tabBarBackgroundImage;
        tabBar.drawColor = tabBarDrawColor;
        tabBar.backgroundColor = tabBarBackgroundColor;
        tabBar.enabled = tabBarEnabled;

        tabBar.buttons = tabBarButtons;
        [self configureTabBar];
        [self setupControllers];
        
        [self.view addSubview:tabBar];
        [tabBar release];
    }
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - 
//==============================================================================
- (void) setTabBarEnabled:(BOOL)aTabBarEnabled
{
    tabBarEnabled = aTabBarEnabled;
    tabBar.enabled = tabBarEnabled;
}

//==============================================================================
- (void) setSelectedIndex:(NSUInteger)aSelectedIndex
{
    selectedIndex = aSelectedIndex;
    stackedView.currentIndex = selectedIndex;
}

//==============================================================================
- (UIViewController*) selectedViewController
{
    
    return ([viewControllers count] > 0 && selectedIndex < [viewControllers count]) ? ([viewControllers objectAtIndex:selectedIndex]) : nil;
}

//==============================================================================
- (void) setSelectedViewController:(UIViewController *)aSelectedViewController
{
    // !!!!!!
}

//==============================================================================
- (CGRect) getContentFrame
{
    float y = (tabBarOnTheTop) ? (tabBarHeight) : (0);
    return CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - tabBarHeight);
}

//==============================================================================
- (void) setViewControllers:(NSArray *)aViewControllers
{
    if(viewControllers != aViewControllers)
    {
        // remove old controllers
        for(UIViewController* vc in viewControllers)
            [vc.view removeFromSuperview];
        [viewControllers release];
        
        viewControllers = [aViewControllers copy];

        // setup new controllers
        if(tabBar)
        {
            [self setupControllers];
        }
    }
    
}

//==============================================================================
- (void) setupControllers
{
    for(UIViewController* vc in viewControllers)
    {
        vc.view.frame = stackedView.bounds;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self.view addSubview:vc.view];
    }
    [self setSelectedIndex:selectedIndex];
}

//==============================================================================
- (void) configureTabBar
{
    // empty by default
}

#pragma mark - MUTabedToolbarDelegate
//==============================================================================
- (void) tabedToolbar:(MUTabedToolbar*)aTabBar itemChangedTo:(NSUInteger)aToIndex from:(NSUInteger)aFromIndex
{
}

#pragma mark - MUStackedViewDelegate
//==============================================================================


@end
