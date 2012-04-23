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

//==============================================================================
@interface MUTabBarItem : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIColor* titleColor;
@property (nonatomic, assign) UIFont* titleFont;
@property (nonatomic, retain) UIColor* titleShadowColor;
@property (nonatomic, assign) CGSize titleShadowOffset;

@property (nonatomic, retain) UIImage* imageNormal;
@property (nonatomic, retain) UIImage* imageSelected;

@property (nonatomic, retain) UIImage* backgroundImageNormal;
@property (nonatomic, retain) UIImage* backgroundImageSelected;

@end

@class MUTabBarController;
//==============================================================================
@protocol MUTabBarItemProtocol <NSObject>

@property (nonatomic, retain) MUTabBarItem* mutabBarItem;
@property (nonatomic, assign) MUTabBarController* mutabBarController;
@end

//==============================================================================
@protocol MUTabBarControllerDelegate<NSObject>

- (BOOL) tabBarController:(MUTabBarController*)aTabBarController shouldSelectViewController:(UIViewController *)aViewController;
- (void) tabBarController:(MUTabBarController *)aTabBarController didSelectViewController:(UIViewController *)aViewController;

@end

//==============================================================================
typedef enum MUTabBarControllerStyle
{
    MUTabBarControllerStyleTabsFullSize,
    MUTabBarControllerStyleTabsSizeByBGImage
    
} MUTabBarControllerStyle;

//==============================================================================
@interface MUTabBarController : UIViewController <MUTabedToolbarDelegate, MUStackedViewDelegate>
{
    MUTabedToolbar* tabBar;
    MUStackedView* stackedView;
    UIButton* disabledButton;
}

@property (nonatomic, assign) id<MUTabBarControllerDelegate> delegate;

@property (nonatomic, assign) MUTabBarControllerStyle style;

@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, assign) BOOL tabBarOnTheTop;
@property (nonatomic, retain) UIImage* tabBarBackgroundImage;
@property (nonatomic, assign) BOOL tabBarDrawColor;
@property (nonatomic, retain) UIColor* tabBarBackgroundColor;
@property (nonatomic, assign) BOOL tabBarEnabled;

@property (nonatomic, copy) NSArray* viewControllers;
@property (nonatomic, assign) UIViewController* selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (void) configureTabBar;                                                               ///< Override to customize tabBar
- (void) configureTabBarButton:(UIButton*)aTabBarButton atIndex:(NSUInteger)anIndex;    ///< Override to customize tabBarItem
- (CGFloat) spaceBeforeTabBarButtonAtIndex:(NSUInteger)anIndex;                         ///< Override to configure additional space

@end


//==============================================================================
@interface UIViewController (MUTabBarController)

@property (nonatomic, assign) MUTabBarController* mutabBarController;

@end