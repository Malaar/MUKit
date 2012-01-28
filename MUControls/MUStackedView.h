//
//  MUStackedView.h
//  TimeLink
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
- (void) stackedSubviewWillChangeFromIndex:(NSInteger)aFromIndex toIndex:(NSInteger)aToIndex;
- (void) stackedSubviewDidChangedFromIndex:(NSInteger)aFromIndex toIndex:(NSInteger)aToIndex;

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
- (void) insertStackedSubview:(UIView *)aView atIndex:(NSInteger)aIndex;
- (void) removeStackedSubviewAtIndex:(NSInteger)aIndex;
- (void) removeStackedSubview:(UIView *)aView;
- (void) removeAllStackedSubviews;

@end
