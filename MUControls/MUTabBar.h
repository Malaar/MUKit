//
//  MUTabBar.h
//  ROM
//
//  Created by Malaar on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
@class MUTabBar;

@protocol MUTabBarDelegate <NSObject>

- (void) tabBar:(MUTabBar*)aTabBar itemChangedTo:(int)aToIndex from:(int)aFromIndex;

@optional


@end



//==============================================================================
//==============================================================================
//==============================================================================
///
@interface MUTabBar : UIToolbar
{
    UIImage* bgImage;
    UIButton* currentItem;
    
	id<MUTabBarDelegate> delegate;
    
    NSMutableArray* buttons;
	
	BOOL enabled;
}

@property (nonatomic, retain) UIImage* backgroundImage;
@property (nonatomic, assign) id<MUTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray* buttons;
@property (nonatomic, assign) BOOL enabled;

- (void) switchToItemWithIndex:(NSInteger)aIndex;                              ///< programmaticaly switch to title by index

@end
