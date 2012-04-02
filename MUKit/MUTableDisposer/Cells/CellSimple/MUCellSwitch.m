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
- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MUCellDataSwitch *cellDataSwitch = (MUCellDataSwitch*)self.cellData;
    
    UISwitch *swither = [[[UISwitch alloc] init] autorelease];
    
    [swither addTarget:cellDataSwitch.targetAction.target action:cellDataSwitch.targetAction.action forControlEvents:UIControlEventValueChanged];
    swither.on = cellDataSwitch.boolValue;
    swither.enabled = cellDataSwitch.enableEdit;
    
    self.accessoryView = swither;
    [swither sizeToFit];
}

@end
