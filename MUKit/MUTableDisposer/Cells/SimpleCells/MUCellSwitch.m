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

- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MUCellDataSwitch *booleanCellData = (MUCellDataSwitch*)self.cellData;
    
    UISwitch *swither = [[[UISwitch alloc] init] autorelease];
    
    [swither addTarget:booleanCellData.targetAction.target action:booleanCellData.targetAction.action forControlEvents:UIControlEventValueChanged];
    swither.on = booleanCellData.boolValue;
    swither.enabled = booleanCellData.enableEdit;
    
    self.accessoryView = swither;
    [swither sizeToFit];
}

@end
