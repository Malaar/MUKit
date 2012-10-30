//
//  MUPopupPicker.m
//  MUKit
//
//  Created by Malaar on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPopupSimplePicker.h"
#import "MUTitledID.h"


@implementation MUPopupSimplePicker

@synthesize dataSource;

#pragma mark - override next methods to customize:
//==============================================================================
- (UIView*) createPicker
{
//    UIPickerView* pv = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
    UIPickerView* pv = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)] autorelease];
    pv.delegate = self;
    pv.dataSource = self;
    pv.showsSelectionIndicator = YES;
    
    return pv;
}

//==============================================================================
- (UIPickerView*) popupedPicker
{
    return (UIPickerView*)picker;
}

#pragma mark - override next methods to change default behaviours
//==============================================================================
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//==============================================================================
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataSource count];
}

//==============================================================================
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* result = nil;
    NSObject* item = [dataSource objectAtIndex:row];
    if([item isKindOfClass:[MUTitledID class]])
        result = ((MUTitledID*)item).title;
    else if([item isKindOfClass:[NSString class]])
        result = (NSString*)item;
    else
    {
        NSAssert(NO, @"Wrong class in dataSource !!!");
    }
    
    return result;
}

//==============================================================================
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUPPICKER_VALUE_DID_CHANGE object:self userInfo:nil];
}

//==============================================================================
- (NSObject*) selectedItem
{
    int index = [self.popupedPicker selectedRowInComponent:0];
    return [dataSource objectAtIndex:index];
}

//==============================================================================
- (void) popupWillAppear:(BOOL)animated
{
    [super popupWillAppear:animated];

    NSLog(@"sel:%@; ds: %@", selectedItem, dataSource);
    
    // setup current value
    if(selectedItem)
    {
        NSUInteger index = [dataSource indexOfObject:selectedItem];
        if(index != NSNotFound)
        {
            [self.popupedPicker selectRow:index inComponent:0 animated:NO];
        }
    }
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
