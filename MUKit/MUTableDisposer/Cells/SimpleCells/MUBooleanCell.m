//
//  MUBooleanCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUBooleanCell.h"
#import "MUBooleanCellData.h"

@implementation MUBooleanCell

- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    MUBooleanCellData *booleanCellData = (MUBooleanCellData *)self.cellData;
    
    UISwitch *swither = [[[UISwitch alloc] init] autorelease];
    
    [swither addTarget:booleanCellData.switchTarget action:booleanCellData.switchAction forControlEvents:UIControlEventValueChanged];
    swither.on = booleanCellData.boolValue;
    swither.enabled = booleanCellData.enableEdit;
    
    [self.accessoryView addSubview:swither];
    [swither sizeToFit];
}

@end
