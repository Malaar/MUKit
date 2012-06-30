//
//  MUPopoverViewController.h
//  MUKit
//
//  Created by Malaar on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUPopupView.h"

@interface MUPopoverViewController : UIViewController
{
    MUPopupView* popupedView;
}

@property (nonatomic, assign) UIPopoverController* popoverOwner;

- (id) initWithPopupView:(MUPopupView*)aPopupedView;

@end
