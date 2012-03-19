//
//  MUPopupPicker.h
//  TimeLink
//
//  Created by Malaar on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUPopupPicker.h"

/**
 * This class can work with dataSource elements of classes MUTitledID or NSString, else generate assert.
 * This picker has only one component in pickerView.
 */
@interface MUPopupSimplePicker : MUPopupPicker <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray* dataSource;
}

@property (nonatomic, copy) NSArray* dataSource;
@property (nonatomic, readonly) UIPickerView* popupedPicker;

@end
