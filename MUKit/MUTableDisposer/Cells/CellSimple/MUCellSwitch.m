//
//  MUBooleanCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellSwitch.h"
#import "MUCellDataSwitch.h"

@implementation MUCellSwitch

//==============================================================================
- (void) setupCellData:(MUCellDataSwitch *)aCellData
{
    [super setupCellData:aCellData];
    
    UISwitch *switcher = [[[UISwitch alloc] init] autorelease];
    
    [switcher addTarget:aCellData.targetAction.target action:aCellData.targetAction.action forControlEvents:UIControlEventValueChanged];
    switcher.on = aCellData.boolValue;
    switcher.enabled = aCellData.enableEdit;
    
    self.accessoryView = switcher;
    [switcher sizeToFit];
}

@end
