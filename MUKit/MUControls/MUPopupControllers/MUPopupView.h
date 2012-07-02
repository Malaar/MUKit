//
//  MUPopupView.h
//  MUKit
//
//  Created by Malaar on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUKitDefines.h"
#import "MUWeakRef.h"
#import "MUPopupViewController.h"


#define POPUPVIEW_WILL_SHOW     @"PopupViewWillShow"
#define POPUPVIEW_DID_SHOW      @"PopupViewDidShow"
#define POPUPVIEW_WILL_HIDE     @"PopupViewWillHide"
#define POPUPVIEW_DID_HIDE      @"PopupViewDidHide"

@interface MUPopupView : UIView <MUWeakRefProtocol>
{
	MUWeakRef* weakRef;
}

@property (nonatomic, readonly) NSObject* showStrategy;
@property (nonatomic, assign) BOOL hideByTapOutside;
@property (nonatomic, assign) BOOL showOverlayView;                             ///< determine show or not overlay view (by default it is gray transparent view above any free space)

- (void) prepareToRelease;

- (void) hideWithAnimation:(BOOL)animation;                                     ///< hide with popup strategy (works only on iPad)

// for iPhone
- (void) showWithAnimation:(BOOL)animation inView:(UIView*)aView;               ///< show with popup strategy (works only on iPhone)

// for iPad
- (void)showFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

// -----
- (void) setup;
- (void) prepareToShow;

// use it only in subclasses of this class, dont cull it manyally in your code (outside of subclasses of this classe)
- (void) popupWillAppear:(BOOL)animated;
- (void) popupDidAppear:(BOOL)animated;
- (void) popupWillDisappear:(BOOL)animated;
- (void) popupDidDisappear:(BOOL)animated;


@end
