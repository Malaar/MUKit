//
//  MUTabBarController.m
//  MUKitTest
//
//  Created by Malaar on 07.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTabBarController.h"

#define MU_IS_OS_VER_5x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)

//==============================================================================
@implementation MUTabBarItem

@synthesize title;
@synthesize titleColor;
@synthesize titleFont;
@synthesize titleShadowColor;
@synthesize titleShadowOffset;
@synthesize imageNormal;
@synthesize imageSelected;
@synthesize backgroundImageNormal;
@synthesize backgroundImageSelected;

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        self.titleColor = [UIColor whiteColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleShadowColor = [UIColor clearColor];
        self.titleShadowOffset = CGSizeZero;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [title release];
    [titleColor release];
    [titleShadowColor release];
    [imageNormal release];
    [imageSelected release];
    [backgroundImageNormal release];
    [backgroundImageSelected release];
    
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTabBarController ()

- (CGRect) getContentFrame;
- (void) setupControllers;
- (void) correctForNavigationController:(UIViewController**)vc;
- (UIBarButtonItem*) spacerBeforeTabBarButtonAtIndex:(NSUInteger)anIndex;
- (void) disabledButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTabBarController

@synthesize delegate;

@synthesize style;
@synthesize tabBarOnTheTop;
@synthesize tabBarHeight;
@synthesize tabBarBackgroundImage;
@synthesize tabBarDrawColor;
@synthesize tabBarBackgroundColor;
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
        tabBarHeight = 49;
        selectedIndex = 0;
        tabBarEnabled = YES;
        isFirstSetIndex = YES;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [tabBarBackgroundImage release];
    [tabBarBackgroundColor release];
    
    [viewControllers release];
    
    [super dealloc];
}

#pragma mark - View Lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

//==============================================================================
- (void)viewDidUnload
{
    tabBar = nil;
    disabledButton = nil;
    contentView = nil;
    currentView = nil;
    
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!contentView)
    {
        contentView = [[UIView alloc] initWithFrame:[self getContentFrame]];
        contentView.backgroundColor = [UIColor yellowColor];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        if(tabBarOnTheTop)
//            contentView.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
//        else
//            contentView.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
        [self.view addSubview:contentView];
        [contentView release];
    }
    
    if(!tabBar)
    {
        // create tabBar
        float y = (tabBarOnTheTop) ? (0) : (self.view.bounds.size.height - tabBarHeight);
        tabBar = [[MUTabedToolbar alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, tabBarHeight)];
        tabBar.delegate = self;
        tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tabBar.autoresizingMask |= (tabBarOnTheTop) ? (UIViewAutoresizingFlexibleBottomMargin) : (UIViewAutoresizingFlexibleTopMargin);
        tabBar.backgroundImage = tabBarBackgroundImage;
        tabBar.drawColor = tabBarDrawColor;
        tabBar.backgroundColor = tabBarBackgroundColor;
        tabBar.enabled = tabBarEnabled;

        [self configureTabBar];
        [self setupControllers];
        
        [self.view addSubview:tabBar];
        [tabBar release];
    }
    

    if(!MU_IS_OS_VER_5x)
        [[self selectedViewController] viewWillAppear:animated];
}

//==============================================================================
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!MU_IS_OS_VER_5x)
        [[self selectedViewController] viewDidAppear:animated];
}

//==============================================================================
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(!MU_IS_OS_VER_5x)
        [[self selectedViewController] viewWillDisappear:animated];
}

//==============================================================================
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    if(!MU_IS_OS_VER_5x)
        [[self selectedViewController] viewDidDisappear:animated];
}

//==============================================================================
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    BOOL result = YES;
    
    for(UIViewController* vc in viewControllers)
        result &= [vc shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    
    return result;
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
    // save prev
    UIViewController* prevController = [self selectedViewController];
    UIView* prevView = currentView;
    
    // get new
    selectedIndex = aSelectedIndex;
    UIViewController* newController = [self selectedViewController];

    // switch tabBar
    [tabBar switchToItemWithIndex:selectedIndex];
    disabledButton.frame = [[tabBar.buttons objectAtIndex:aSelectedIndex] frame];

    // will hide prev
    if(prevView)
    {
        if(MU_IS_OS_VER_5x)
            [prevController removeFromParentViewController];
        else
            [prevController viewWillDisappear:NO];
    }

    // will show new
    currentView = newController.view;
    currentView.frame = contentView.bounds;
    currentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if(!MU_IS_OS_VER_5x)
        [newController viewWillAppear:NO];

    // did hide prev
    if(prevView)
    {
        [prevView removeFromSuperview];
        if(!MU_IS_OS_VER_5x)
            [prevController viewDidDisappear:YES];
    }
    
    // did show new
    [contentView addSubview:currentView];
    if(MU_IS_OS_VER_5x)
        [self addChildViewController:newController];
    else
        [newController viewDidAppear:NO];
    
    // delegate
    if([delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
        [delegate tabBarController:self didSelectViewController:[viewControllers objectAtIndex:aSelectedIndex]];
}

//==============================================================================
- (UIViewController*) selectedViewController
{
    return ([viewControllers count] > 0 && selectedIndex < [viewControllers count]) ? ([viewControllers objectAtIndex:selectedIndex]) : nil;
}

//==============================================================================
- (void) setSelectedViewController:(UIViewController *)aSelectedViewController
{
    NSUInteger index = [viewControllers indexOfObject:aSelectedViewController];
    if(index != NSNotFound)
    {
        [self setSelectedIndex:index];
    }
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
        selectedIndex = 0;
        
        // remove old controllers
        [currentView removeFromSuperview];
        currentView = nil;
        if(MU_IS_OS_VER_5x)
        {
            for(UIViewController* vc in viewControllers)
                [vc removeFromParentViewController];
        }
        [viewControllers release];

        // save new controllers
        viewControllers = [aViewControllers copy];

        // setup new controllers
        if(tabBar)
        {
            [self setupControllers];
        }
    }
    
}

//==============================================================================
- (void) correctForNavigationController:(UIViewController**)vc
{
    if([*vc isKindOfClass:[UINavigationController class]])
    {
        if([[(UINavigationController*)(*vc) viewControllers] count] > 0)
            *vc = [[(UINavigationController*)(*vc) viewControllers] objectAtIndex:0];
        else
        {
            NSAssert(NO, @"NAvigation controller without root controller!");
        }
    }
}

//==============================================================================
- (void) setupControllers
{
    CGSize tabBarItemFullSize = CGSizeMake(tabBar.bounds.size.width / [viewControllers count], tabBar.bounds.size.height);
    NSUInteger tabBarButtonIndex = 0;
    
    NSMutableArray* tabs = [NSMutableArray arrayWithCapacity:[viewControllers count]];
    
    for(UIViewController* vc in viewControllers)
    {
        [tabs addObject:[self spacerBeforeTabBarButtonAtIndex:tabBarButtonIndex]];

        [self correctForNavigationController:&vc];
        
        vc.mutabBarController = self;
        
        // get tabBarItem
        NSAssert([vc conformsToProtocol:@protocol(MUTabBarItemProtocol)], @"View controller must implement protocol MUTabBarItemProtocol!");
        MUTabBarItem* tabBarItem = [(id<MUTabBarItemProtocol>)vc mutabBarItem];
        NSAssert(tabBarItem, @"tabBarItem must be non nil!");
        
        // create tabBar button and configure
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [button setTitle:tabBarItem.title forState:UIControlStateNormal];
        [button setTitleColor:tabBarItem.titleColor forState:UIControlStateNormal];
        [button setTitleShadowColor:tabBarItem.titleShadowColor forState:UIControlStateNormal];
        button.titleLabel.font = tabBarItem.titleFont;
        button.titleLabel.shadowOffset = tabBarItem.titleShadowOffset;

        [button setBackgroundImage:tabBarItem.backgroundImageNormal forState:UIControlStateNormal];
        if(tabBarItem.backgroundImageSelected)
            [button setBackgroundImage:tabBarItem.backgroundImageSelected forState:UIControlStateDisabled];
        
        [button setImage:tabBarItem.imageNormal forState:UIControlStateNormal];
        if(tabBarItem.imageSelected)
            [button setImage:tabBarItem.imageSelected forState:UIControlStateDisabled];
        
        if(style == MUTabBarControllerStyleTabsFullSize)
        {
            button.frame = CGRectMake(0, 0, tabBarItemFullSize.width, tabBarItemFullSize.height);
        }
        else if(style == MUTabBarControllerStyleTabsSizeByBGImage)
        {
            button.frame = CGRectMake(0, 0, tabBarItem.backgroundImageNormal.size.width, tabBarItem.backgroundImageNormal.size.height);
        }
        else
        {
            NSAssert(NO, @"Other style don't supported yet!");
        }
        
        [self configureTabBarButton:button atIndex:tabBarButtonIndex];
        
        UIBarButtonItem* bbi = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
        [tabs addObject:bbi];
                
        tabBarButtonIndex++;
    }
    
    tabBar.items = tabs;
    
    // disable button
    disabledButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabBar addSubview:disabledButton];
    [disabledButton addTarget:self action:@selector(disabledButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self setSelectedIndex:selectedIndex];
}

//==============================================================================
- (void) configureTabBar
{
    // empty by default
}

//==============================================================================
- (void) configureTabBarButton:(UIButton*)aTabBarButton atIndex:(NSUInteger)anIndex
{
    // empty by default
}

//==============================================================================
- (UIBarButtonItem*) spacerBeforeTabBarButtonAtIndex:(NSUInteger)anIndex
{
    UIBarButtonItem* result = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] autorelease];
    result.width = [self spaceBeforeTabBarButtonAtIndex:anIndex];
    return result;
}

//==============================================================================
- (CGFloat) spaceBeforeTabBarButtonAtIndex:(NSUInteger)anIndex
{
    CGFloat result = 0.0f;
    if(style == MUTabBarControllerStyleTabsFullSize)
    {
        if(anIndex == 0)
            result = -12;
        else
            result = -10;
    }
    return result;
}

//==============================================================================
- (void) disabledButtonPressed
{
    if([self.selectedViewController isKindOfClass:[UINavigationController class]])
    {
        [((UINavigationController*)self.selectedViewController) popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - MUTabedToolbarDelegate
//==============================================================================
- (BOOL) tabedToolbar:(MUTabedToolbar *)aTabBar shouldSelectItemAtIndex:(NSUInteger)anIndex
{
    BOOL result = YES;
    if([delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
    {
        [delegate tabBarController:self shouldSelectViewController: [viewControllers objectAtIndex:anIndex]];
    }
    return result;
}

//==============================================================================
- (void) tabedToolbar:(MUTabedToolbar*)aTabBar itemChangedTo:(NSUInteger)aToIndex from:(NSUInteger)aFromIndex
{
    [self setSelectedIndex:aToIndex];
}

@end
