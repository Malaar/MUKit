//
//  MUPopupHoursMinutesPicker.m
//  TimeLink
//
//  Created by Malaar on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPopupHoursMinutesPicker.h"


@implementation MUPopupHoursMinutesPicker

#pragma mark - override next methods to customize:
//==============================================================================
- (UIView*) createPicker
{
//    UIDatePicker* pv = [[[UIDatePicker alloc] initWithFrame:CGRectZero] autorelease];
//    pv.datePickerMode = UIDatePickerModeCountDownTimer;
//    UIPickerView* pv = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
    UIPickerView* pv = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)] autorelease];
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
    NSNumber* result = nil;

    int hours = [self.popupedPicker selectedRowInComponent:0];
    int minutes = [self.popupedPicker selectedRowInComponent:1];
    result = [NSNumber numberWithInt:60 * hours + minutes];
//    result = [[MUConvertor sharedConvertor] dateFromTimeHours:hours minutes:minutes seconds:0];

    return result;
}

//==============================================================================
- (void) popupWillAppear:(BOOL)animated
{
    [super popupWillAppear:animated];
    
    CGRect frame;
    
    // hours
    if([self.showStrategy isKindOfClass:[UIViewController class]] && UIInterfaceOrientationIsPortrait(((UIViewController*)self.showStrategy).interfaceOrientation) )
        frame = CGRectMake(60, 130, 70, 44);
    else
        frame = CGRectMake(60, 90, 70, 44);

    UILabel* lbHours = [[UILabel alloc] initWithFrame:frame];
    lbHours.text = @"hours";
    lbHours.backgroundColor = [UIColor clearColor];
    [self addSubview:lbHours];
    [lbHours release];

    // minutes
    if([self.showStrategy isKindOfClass:[UIViewController class]] && UIInterfaceOrientationIsPortrait(((UIViewController*)self.showStrategy).interfaceOrientation) )
        frame = CGRectMake(200, 130, 70, 44);
    else
        frame = CGRectMake(370, 90, 70, 44);

    UILabel* lbMinutes = [[UILabel alloc] initWithFrame:frame];
    lbMinutes.text = @"minutes";
    lbMinutes.backgroundColor = [UIColor clearColor];
    lbMinutes.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:lbMinutes];
    [lbMinutes release];

    // setup current value
    if(selectedItem)
    {
        NSNumber* selNumber = (NSNumber*)selectedItem;
        [self.popupedPicker selectRow:[selNumber intValue] / 60 inComponent:0 animated:NO];
        [self.popupedPicker selectRow:[selNumber intValue] % 60 inComponent:1 animated:NO];
//        NSDate* selDate = (NSDate*)selectedItem;
//        [self.popupedPicker selectRow:selDate.hour inComponent:0 animated:NO];
//        [self.popupedPicker selectRow:selDate.minute inComponent:1 animated:NO];
    }
}

//==============================================================================
@end
