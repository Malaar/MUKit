//
//  MUPopupHoursMinutesPicker.m
//  TimeLink
//
//  Created by Malaar on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPopupHoursMinutesPicker.h"
#import "NSDate-Utilities.h"

@implementation MUPopupHoursMinutesPicker

#pragma mark - override next methods to customize:
//==============================================================================
- (UIView*) createPicker
{
//    UIDatePicker* pv = [[[UIDatePicker alloc] initWithFrame:CGRectZero] autorelease];
//    pv.datePickerMode = UIDatePickerModeCountDownTimer;
    UIPickerView* pv = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
    pv.dataSource = self;
    pv.delegate = self;
    pv.showsSelectionIndicator = YES;
    
    return pv;
}

//==============================================================================
- (UIPickerView*) popupedPicker
{
    return (UIPickerView*)picker;
}

//==============================================================================
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//==============================================================================
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (component == 0) ? (24) : (60);
}

//==============================================================================
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%i", row];
}

//==============================================================================
- (NSObject*) selectedItem
{
    NSDateComponents* dc = [[[NSDateComponents alloc] init] autorelease];
    dc.hour = [self.popupedPicker selectedRowInComponent:0];
    dc.minute = [self.popupedPicker selectedRowInComponent:1];

    return [[NSCalendar currentCalendar] dateFromComponents:dc];
}

//==============================================================================
- (void) popupWillAppear:(BOOL)animated
{
    [super popupWillAppear:animated];
    
    CGRect frame;
    
    // hours
    if( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
        frame = CGRectMake(60, 130, 70, 44);
    else
        frame = CGRectMake(60, 90, 70, 44);

    UILabel* lbHours = [[UILabel alloc] initWithFrame:frame];
    lbHours.text = @"hours";
    lbHours.backgroundColor = [UIColor clearColor];
    [popupedView addSubview:lbHours];
    [lbHours release];

    // minutes
    if( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
        frame = CGRectMake(200, 130, 70, 44);
    else
        frame = CGRectMake(370, 90, 70, 44);

    UILabel* lbMinutes = [[UILabel alloc] initWithFrame:frame];
    lbMinutes.text = @"minutes";
    lbMinutes.backgroundColor = [UIColor clearColor];
    lbMinutes.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [popupedView addSubview:lbMinutes];
    [lbMinutes release];

    // setup current value
    if(selectedItem)
    {
        NSDate* selDate = (NSDate*)selectedItem;
        [self.popupedPicker selectRow:selDate.hour inComponent:0 animated:NO];
        [self.popupedPicker selectRow:selDate.minute inComponent:1 animated:NO];
    }
}

//==============================================================================
@end
