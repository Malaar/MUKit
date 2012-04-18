//
//  MUStackedView.m
//  MUKit
//
//  Created by Malaar on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUStackedView.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUStackedView (Private)

- (void) setup;
- (void) switchToStackedSubview:(UIView*)aStackedSubview;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUStackedView


@synthesize delegate;
@synthesize currentIndex = currentIndex;
@synthesize currentStackedSubview = currentView;
@dynamic countStackedSubviews;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithFrame:(CGRect)frame
{
    if ( (self = [super initWithFrame:frame]) )
    {
        [self setup];
    }

    return self;
}

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        [self setup];
    }
    
    return self;
}

//==============================================================================
- (void) dealloc
{
    [stackedSubviews release];
    
    [super dealloc];
}

//==============================================================================
- (void) setup
{
    self.clipsToBounds = YES;
    stackedSubviews = [NSMutableArray new];
}

#pragma mark - Add/Remove stacked subviews
//==============================================================================
- (void) addStackedSubview:(UIView *)aView
{
    NSAssert(aView, @"aView is nil !!!");
    [stackedSubviews addObject:aView];
//    [self addSubview:aView];
//    aView.hidden = YES;
}

//==============================================================================
- (void) insertStackedSubview:(UIView *)aView atIndex:(NSUInteger)aIndex
{
    NSAssert(aView, @"aView is nil !!!");
    [stackedSubviews insertObject:aView atIndex:aIndex];
//    [self addSubview:aView];
//    aView.hidden = YES;
}

//==============================================================================
- (void) removeStackedSubviewAtIndex:(NSUInteger)aIndex
{
    UIView* view = [stackedSubviews objectAtIndex:aIndex];
    if(view == currentView)
    {
        [currentView removeFromSuperview];
        currentView = nil;
    }
//    [view removeFromSuperview];
    [stackedSubviews removeObjectAtIndex:aIndex];
}

//==============================================================================
- (void) removeStackedSubview:(UIView *)aView
{
    NSAssert(aView, @"aView is nil !!!");
    NSUInteger index = [stackedSubviews indexOfObject:aView];
    [self removeStackedSubviewAtIndex:index];
}

//==============================================================================
- (void) removeAllStackedSubviews
{
//    for(UIView* view in stackedSubviews)
//    {
//        [view removeFromSuperview];
//    }
    [stackedSubviews removeAllObjects];
    [currentView removeFromSuperview];
    currentView = nil;
}

//==============================================================================
- (NSUInteger) countStackedSubviews
{
    return [stackedSubviews count];
}

#pragma mark - Switch between stacked subviews
//==============================================================================
- (void) setCurrentIndex:(NSUInteger)aCurrentIndex
{
    if(aCurrentIndex < [stackedSubviews count])
    {
        [self switchToStackedSubview:[stackedSubviews objectAtIndex:aCurrentIndex]];
    }
}

//==============================================================================
- (void) setCurrentStackedSubview:(UIView *)aCurrentStackedSubview
{
    NSUInteger index = [stackedSubviews indexOfObject:aCurrentStackedSubview];
    [self setCurrentIndex:index];
    
//    if(aCurrentStackedSubview.superview == self)
//    {
//        [self switchToStackedSubview:aCurrentStackedSubview];
//    }
}

//==============================================================================
- (void) switchToStackedSubview:(UIView*)aStackedSubview
{
    NSUInteger fromIndex = (currentView) ? ([stackedSubviews indexOfObject:currentView]) : (NSNotFound);
    NSUInteger toIndex = [stackedSubviews indexOfObject:aStackedSubview];
    
    if(delegate && [delegate respondsToSelector:@selector(stackedView:willChangeFromIndex:toIndex:)])
        [delegate stackedView:self willChangeFromIndex:fromIndex toIndex:toIndex];

//    currentView.hidden = YES;
    [currentView removeFromSuperview];
    currentView = aStackedSubview;
    currentView.hidden = NO;
    [self addSubview:currentView];
    currentView.frame = self.bounds;

    currentIndex = toIndex;

    if(delegate && [delegate respondsToSelector:@selector(stackedView:didChangedFromIndex:toIndex:)])
        [delegate stackedView:self didChangedFromIndex:fromIndex toIndex:toIndex];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
