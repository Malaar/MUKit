//
//  MUStackedView.h
//  MUKit
//
//  Created by Malaar on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//==============================================================================
//==============================================================================
//==============================================================================
@protocol MUStackedViewDelegate <NSObject>

@optional
- (void) stackedSubviewWillChangeFromIndex:(NSUInteger)aFromIndex toIndex:(NSUInteger)aToIndex;
- (void) stackedSubviewDidChangedFromIndex:(NSUInteger)aFromIndex toIndex:(NSUInteger)aToIndex;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUStackedView : UIView
{
    NSMutableArray* stackedSubviews;
    UIView* currentView;
    id<MUStackedViewDelegate> delegate;
}

@property (nonatomic, assign) id<MUStackedViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) UIView* currentStackedSubview;
@property (nonatomic, readonly) NSUInteger countStackedSubviews;

- (void) addStackedSubview:(UIView *)aView;
- (void) insertStackedSubview:(UIView *)aView atIndex:(NSUInteger)aIndex;
- (void) removeStackedSubviewAtIndex:(NSUInteger)aIndex;
- (void) removeStackedSubview:(UIView *)aView;
- (void) removeAllStackedSubviews;

@end
