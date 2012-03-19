//
//  MUPopupHoursMinutesPicker.h
//  TimeLink
//
//  Created by Malaar on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUPopupDatePicker.h"


@interface MUPopupHoursMinutesPicker : MUPopupPicker <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, readonly) UIPickerView* popupedPicker;

@end
