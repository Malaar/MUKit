//
//  MUModalView.h
//  MUKit
//
//  Created by Malaar on 12.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUModalView : UIView

@property (nonatomic, assign) CGPoint centerDelta;
@property (nonatomic, assign) BOOL hideByTapOutside;
@property (nonatomic, assign) CGFloat overlayAlpha;
@property (nonatomic, assign) UIColor* overlayColor;

+ (MUModalView*)modalView;

- (void)showInView:(UIView*)aView animate:(BOOL)anAnimate;
- (void)hide:(BOOL)anAnimate;

+ (void)showInView:(UIView*)aView animate:(BOOL)anAnimate;
+ (void)hideFromView:(UIView*)aView animate:(BOOL)anAnimate;

@end
