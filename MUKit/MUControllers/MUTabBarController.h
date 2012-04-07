//
//  MUTabBarController.h
//  MUKitTest
//
//  Created by Malaar on 07.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUTabedToolbar.h"
#import "MUStackedView.h"

@class MUTabBarController;
//==============================================================================
@protocol MUTabBarControllerDelegate<NSObject>

- (BOOL) tabBarController:(MUTabBarController*)aTabBarController shouldSelectViewController:(UIViewController *)aViewController;
- (void) tabBarController:(MUTabBarController *)aTabBarController didSelectViewController:(UIViewController *)aViewController;

@end

//==============================================================================
@interface MUTabBarController : UIViewController <MUTabedToolbarDelegate, MUStackedViewDelegate>
{
    MUTabedToolbar* tabBar;
    MUStackedView* stackedView;
    
}

@property (nonatomic, assign) id<MUTabBarControllerDelegate> delegate;

@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, assign) BOOL tabBarOnTheTop;
@property (nonatomic, retain) UIImage* tabBarBackgroundImage;
@property (nonatomic, assign) BOOL tabBarDrawColor;
@property (nonatomic, retain) UIColor* tabBarBackgroundColor;
@property (nonatomic, copy) NSArray* tabBarButtons;
@property (nonatomic, assign) BOOL tabBarEnabled;

@property (nonatomic, copy) NSArray* viewControllers;
@property (nonatomic, assign) UIViewController* selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (void) configureTabBar;                                                       ///< Override to customize tabBar

@end


//==============================================================================
@interface UIViewController (MUTabBarController)

@property (nonatomic, assign) MUTabBarController* mutabBarController;

@end