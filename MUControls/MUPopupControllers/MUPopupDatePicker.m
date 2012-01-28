//
//  MUPopupDatePicker.m
//  TimeLink
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPopupDatePicker.h"


@implementation MUPopupDatePicker

@synthesize popupedPicker;

#pragma mark - override next methods to customize:
//==============================================================================
- (UIView*) createPicker
{
    UIDatePicker* pv = [[[UIDatePicker alloc] initWithFrame:CGRectZero] autorelease];
    pv.datePickerMode = UIDatePickerModeDate;
    
    return pv;
}

//==============================================================================
- (UIDatePicker*) popupedPicker
{
    return (UIDatePicker*)self->picker;
}

//==============================================================================
- (NSObject*) selectedItem
{
    return self.popupedPicker.date;
}

//==============================================================================
- (void) popupWillAppear:(BOOL)animated
{
    [super popupWillAppear:animated];
    
    // setup current value
    if(self->selectedItem)
    {
        if([self->selectedItem isKindOfClass:[NSDate class]])
        {
            self.popupedPicker.date = (NSDate*)self->selectedItem;
        }
        else
        {
            NSAssert(NO, @"Wrong class type !!!");
        }
    }
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
