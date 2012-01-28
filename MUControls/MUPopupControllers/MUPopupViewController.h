//
//  MUPopupViewController.h
//  TimeLink
//
//  Created by Malaar on 25.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUWeakRef.h"

#define POPUPVIEW_WILL_SHOW     @"PopupViewWillShow"
#define POPUPVIEW_DID_SHOW      @"PopupViewDidShow"
#define POPUPVIEW_WILL_HIDE     @"PopupViewWillHide"
#define POPUPVIEW_DID_HIDE      @"PopupViewDidHide"


///
@interface MUPopupViewController : UIViewController <MUWeakRefProtocol>
{
@private
	MUWeakRef* weakRef;
	
@protected
    UINavigationController* navigationController;
	
    UIButton* btHided;
    UIView* popupedViewOwner;
    UIView* popupedView;
    UIView* overlayView;
    
    float overlayViewAlpha;
    
    BOOL hideByTapOutside;                                                      ///< if YES, then hide this popupedView when user taps on any free space
    BOOL animatingNow;
    BOOL isShow;
}

@property (nonatomic, assign) BOOL hideByTapOutside;
@property (nonatomic, assign) BOOL showOverlayView;                             ///< determine show or not overlay view (by default it is gray transparent view above any free space)
@property (nonatomic, readonly) UIView* overlayView;                            ///< get overlayView
@property (nonatomic, assign) float overlayViewAlpha;                           ///< change alpha of overlayView (to change color of overlayView use property 'overlayView')
@property (nonatomic, readonly) BOOL isShow;

@property (nonatomic, assign) UINavigationController* navigationController;		///< navigationController

- (void) showWithAnimation:(BOOL)animation inView:(UIView*)aView;               ///< show popupedView
- (void) hideWithAnimation:(BOOL)animation;                                     ///< hide popupedView

- (UIView*) createPopupedView;                                                  ///< Create, configure and return popupedView (override to customize)

// use it only in subclasses of this class, dont cull it manyally in your code (outside of subclasses of this classe)
- (void) popupWillAppear:(BOOL)animated;
- (void) popupDidAppear:(BOOL)animated;
- (void) popupWillDisappear:(BOOL)animated;
- (void) popupDidDisappear:(BOOL)animated;

@end
