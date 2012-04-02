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
    
    UISwitch *swither = [[[UISwitch alloc] init] autorelease];
    
    [swither addTarget:aCellData.targetAction.target action:aCellData.targetAction.action forControlEvents:UIControlEventValueChanged];
    swither.on = aCellData.boolValue;
    swither.enabled = aCellData.enableEdit;
    
    self.accessoryView = swither;
    [swither sizeToFit];
}

@end
