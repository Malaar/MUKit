//
//  MUBooleanCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellSwitch.h"
#import "MUCellDataSwitch.h"
#import "DCRoundSwitch.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCellSwitch ()

- (void) didChangeBoolValueInSwitch:(UISwitch *) aSwitch;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCellSwitch

//==============================================================================
- (void) setupCellData:(MUCellDataSwitch *)aCellData
{
    [super setupCellData:aCellData];
    
    id switcher = nil;
    
    if (aCellData.onText && aCellData.offText) 
    {
        switcher = [[[DCRoundSwitch alloc] init] autorelease];
        ((DCRoundSwitch*)switcher).onText = aCellData.onText;
        ((DCRoundSwitch*)switcher).offText = aCellData.offText;
        ((DCRoundSwitch*)switcher).on = aCellData.boolValue;
        ((DCRoundSwitch*)switcher).enabled = aCellData.enableEdit;
    }
    else
    {
        switcher = [[[UISwitch alloc] init] autorelease];        
        ((UISwitch*)switcher).on = aCellData.boolValue;
        ((UISwitch*)switcher).enabled = aCellData.enableEdit;
        [switcher sizeToFit];
    }
    
    [switcher addTarget:self action:@selector(didChangeBoolValueInSwitch:) forControlEvents:UIControlEventValueChanged];
//    [switcher addTarget:aCellData.targetAction.target action:aCellData.targetAction.action forControlEvents:UIControlEventValueChanged];
    
    self.accessoryView = switcher;
}

#pragma mark - Change Bool Value
//==============================================================================
- (void) didChangeBoolValueInSwitch:(UISwitch *) aSwitch
{
    ((MUCellDataSwitch*)self.cellData).boolValue = aSwitch.on;

    MUCellDataSwitch* cellData = (MUCellDataSwitch*)self.cellData;
    [cellData.targetAction sendActionFrom:cellData];
}

@end
