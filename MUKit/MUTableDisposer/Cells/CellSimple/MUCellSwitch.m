//
//  MUBooleanCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellSwitch.h"
#import "MUCellDataSwitch.h"


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
    
    UISwitch *switcher = [[[UISwitch alloc] init] autorelease];

    [switcher addTarget:self action:@selector(didChangeBoolValueInSwitch:) forControlEvents:UIControlEventValueChanged];
    [switcher addTarget:aCellData.targetAction.target action:aCellData.targetAction.action forControlEvents:UIControlEventValueChanged];
    switcher.on = aCellData.boolValue;
    switcher.enabled = aCellData.enableEdit;
    
    self.accessoryView = switcher;
    [switcher sizeToFit];
}

#pragma mark - Change Bool Value
//==============================================================================
- (void) didChangeBoolValueInSwitch:(UISwitch *) aSwitch
{
    ((MUCellDataSwitch*)self.cellData).boolValue = aSwitch.on;
}

@end
