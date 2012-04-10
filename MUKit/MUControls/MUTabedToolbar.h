//
//  MUTabBar.h
//  MUKit
//
//  Created by Malaar on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUToolbar.h"

//==============================================================================
//==============================================================================
//==============================================================================
@class MUTabedToolbar;

@protocol MUTabedToolbarDelegate <NSObject>

@optional
- (BOOL) tabedToolbar:(MUTabedToolbar*)aTabBar shouldSelectItemAtIndex:(NSUInteger)anIndex;
- (void) tabedToolbar:(MUTabedToolbar*)aTabBar itemChangedTo:(NSUInteger)aToIndex from:(NSUInteger)aFromIndex;

@optional


@end



//==============================================================================
//==============================================================================
//==============================================================================
///
@interface MUTabedToolbar : MUToolbar
{
    UIButton* currentItem;
    
	id<MUTabedToolbarDelegate> delegate;
    
    NSMutableArray* buttons;
	
	BOOL enabled;
}

@property (nonatomic, assign) id<MUTabedToolbarDelegate> delegate;
@property (nonatomic, readonly) NSArray* buttons;
@property (nonatomic, assign) BOOL enabled;

- (void) switchToItemWithIndex:(NSUInteger)aIndex;                              ///< programmaticaly switch to title by index

@end
