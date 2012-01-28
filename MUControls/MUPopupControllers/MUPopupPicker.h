//
//  MUPopupPicker.h
//  TimeLink
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUPopupViewController.h"
#import "MUToolbar.h"


#define POPUPVIEW_TOOLBAR_ITEM_DID_PRESSED      @"PopupViewToolbarItemDidPressed"

#define POPUPVIEW_TOOLBAR_ITEM_PRESSED_INDEX    @"toolbarItemPressedIndex"


@interface MUPopupPicker  : MUPopupViewController
{
    @protected
    MUToolbar* toolbar;
    UIView* picker;
    
    NSObject* selectedItem;
}

@property (nonatomic, retain) MUToolbar* toolbar;
@property (nonatomic, retain) NSObject* selectedItem;

- (UIView*) createPicker;

@end
