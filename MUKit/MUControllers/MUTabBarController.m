//
//  MUTabBarController.m
//  MUKitTest
//
//  Created by Malaar on 07.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTabBarController.h"


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
        tabBarHeight = 49;
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
////==============================================================================
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}

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
        tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
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
    CGSize tabBarItemFullSize = CGSizeMake(tabBar.bounds.size.width / [viewControllers count], tabBar.bounds.size.height);
    CGFloat tabBarItemX = 0;
    NSUInteger tabBarButtonIndex = 0;
    
    NSMutableArray* tabs = [NSMutableArray arrayWithCapacity:[viewControllers count]];
    for(UIViewController* vc in viewControllers)
    {
        vc.view.frame = stackedView.bounds;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [stackedView addStackedSubview:vc.view];
        
        // get tabBarItem
        NSAssert([vc conformsToProtocol:@protocol(MUTabBarItemProtocol)], @"View controller must implement protocol MUTabBarItemProtocol!");
        MUTabBarItem* tabBarItem = [(id<MUTabBarItemProtocol>)vc mutabBarItem];
        NSAssert(tabBarItem, @"tabBarItem must be non nil!");
        
        // create tabBar button and configure
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [button setTitle:tabBarItem.title forState:UIControlStateNormal];
        [button setTitleColor:tabBarItem.titleColor forState:UIControlStateNormal];
        [button setTitleShadowColor:tabBarItem.titleShadowColor forState:UIControlStateNormal];
        button.titleLabel.font = tabBarItem.titleFont;
        button.titleLabel.shadowOffset = tabBarItem.titleShadowOffset;

        [button setBackgroundImage:tabBarItem.backgroundImageNormal forState:UIControlStateNormal];
        if(tabBarItem.backgroundImageSelected)
            [button setBackgroundImage:tabBarItem.backgroundImageSelected forState:UIControlStateSelected];
        
        [button setImage:tabBarItem.imageNormal forState:UIControlStateNormal];
        if(tabBarItem.imageSelected)
            [button setImage:tabBarItem.imageSelected forState:UIControlStateSelected];
        
        if(style == MUTabBarControllerStyleTabsFullSize)
        {
            button.frame = CGRectMake(tabBarItemX, 0, tabBarItemFullSize.width, tabBarItemFullSize.height);
        }
        else
        {
            NSAssert(NO, @"Other style don't supported yet!");
        }
        
        [self configureTabBarButton:button atIndex:tabBarButtonIndex];
        
        UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        [tabs addObject:bbi];
        
        tabBarItemX += tabBarItemFullSize.width;
        tabBarButtonIndex++;
    }
    
    tabBar.items = tabs;
    
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
    stackedView.currentIndex = aToIndex;
}

#pragma mark - MUStackedViewDelegate
////==============================================================================
//- (void) stackedView:(MUStackedView *)aStackedView willChangeFromIndex:(NSUInteger)aFromIndex toIndex:(NSUInteger)aToIndex
//{
//}

//==============================================================================
- (void) stackedView:(MUStackedView *)aStackedView didChangedFromIndex:(NSUInteger)aFromIndex toIndex:(NSUInteger)aToIndex
{
    if([delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
        [delegate tabBarController:self didSelectViewController:[viewControllers objectAtIndex:aToIndex]];
}

@end
