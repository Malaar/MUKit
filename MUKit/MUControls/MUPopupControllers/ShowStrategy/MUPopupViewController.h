//
//  MUPopupViewController.h
//  MUKit
//
//  Created by Malaar on 25.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUPopupView;

///
@interface MUPopupViewController : UIViewController //<MUWeakRefProtocol>
{
@protected
    UIButton* btHided;
    UIView* popupedViewOwner;
    MUPopupView* popupedView;
    UIView* overlayView;
    
    float overlayViewAlpha;
    
    BOOL animatingNow;
    BOOL isShow;
}

@property (nonatomic, retain) MUPopupView* popupedView;
@property (nonatomic, readonly) UIView* overlayView;                            ///< get overlayView
@property (nonatomic, assign) float overlayViewAlpha;                           ///< change alpha of overlayView (to change color of overlayView use property 'overlayView')
@property (nonatomic, readonly) BOOL isShow;

- (void) showWithAnimation:(BOOL)animation inView:(UIView*)aView;               ///< show popupedView
- (void) hideWithAnimation:(BOOL)animation;                                     ///< hide popupedView

@end
