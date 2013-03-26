//
//  MUModalView.m
//  MUKit
//
//  Created by Malaar on 12.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUModalView.h"

@interface MUModalView ()
{
    BOOL animating;
    BOOL setuped;
}

@property (nonatomic, weak) UIView* overlayView;

+ (MUModalView*)modalViewFromView:(UIView*)aView;
- (void)overlayViewPressed;

@end

@implementation MUModalView

@synthesize centerDelta;
@synthesize hideByTapOutside;
@synthesize overlayAlpha;
@synthesize overlayColor;

#pragma mark - Init/Dealloc

+ (MUModalView*)modalView
{
    // override it
    return nil;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setup];
    }
    return self;
}

#pragma mark - Configure

- (void)setup
{
    if (setuped)
        return;
    
    setuped = YES;
    hideByTapOutside = YES;
    centerDelta = CGPointZero;
    overlayAlpha = 0.6f;
    overlayColor = [UIColor blackColor];
}


#pragma mark - Show/Hide methods

+ (void)showInView:(UIView*)aView animate:(BOOL)anAnimate
{
    [[[self class] modalView] showInView:aView animate:YES];
}

+ (void)hideFromView:(UIView *)aView animate:(BOOL)anAnimate
{
    MUModalView* modalView = [[self class] modalViewFromView:aView];
    [modalView hide:YES];
}

- (void)showInView:(UIView*)aView animate:(BOOL)anAnimate
{
    if(animating)
        return;
    
    UIView* overlay = [[UIView alloc] initWithFrame:aView.bounds];
    overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIView* bgView = [[UIView alloc] initWithFrame:overlay.bounds];
    [overlay addSubview:bgView];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.backgroundColor = self.overlayColor;
    bgView.alpha = self.overlayAlpha;
    [overlay addSubview:self];
    self.overlayView = overlay;
    
    if(hideByTapOutside)
    {
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayViewPressed)];
        [bgView addGestureRecognizer:tapRecognizer];
    }

    [aView addSubview:self.overlayView];
    
    self.center = CGPointMake(self.overlayView.bounds.size.width / 2, self.overlayView.bounds.size.height / 2);
    self.center = CGPointMake(self.center.x + centerDelta.x, self.center.y + centerDelta.y);
    
    self.overlayView.alpha = 0;
    if(anAnimate)
    {
        animating = YES;
        [UIView animateWithDuration:0.2 animations:^
         {
             self.overlayView.alpha = 1.0;
             
         } completion:^(BOOL finished)
         {
             animating = NO;
         }];
    }
    else
    {
        self.overlayView.alpha = 1.0;
    }
}

- (void)hide:(BOOL)anAnimate
{
    if(animating)
        return;
    
    if(anAnimate)
    {
        animating = YES;
        [UIView animateWithDuration:0.2 animations:^
         {
             self.overlayView.alpha = 0.0;
             
         } completion:^(BOOL finished)
         {
             animating = NO;
             [self.overlayView removeFromSuperview];
             self.overlayView = nil;
         }];
    }
    else
    {
        [self.overlayView removeFromSuperview];
        self.overlayView = nil;
    }
}

#pragma mark - Actions

- (void)overlayViewPressed
{
    [self hide:YES];
}

#pragma mark - Private

+ (MUModalView*)modalViewFromView:(UIView*)aView
{
    MUModalView* result = nil;
    Class modalClass = [self class];
    for(UIView* view in aView.subviews)
    {
        if([[view.subviews lastObject] isKindOfClass:modalClass])
        {
            result = (MUModalView*)view;
            break;
        }
    }
    return result;
}


@end
