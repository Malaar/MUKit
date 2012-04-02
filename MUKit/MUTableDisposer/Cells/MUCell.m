//
//  MUCell.m
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCell.h"
#import "MUCellData.h"

@implementation MUCell

@synthesize cellData;

//==============================================================================
- (void) setupCellData:(MUCellData *)aCellData
{
    if(cellData != aCellData)
    {
        [cellData release];
        cellData = [aCellData retain];
    }
    
    self.selectionStyle = cellData.cellSelectionStyle;
    self.accessoryType = cellData.cellAccessoryType;
}

//==============================================================================
- (void) dealloc
{
    [cellData release];
    
    [super dealloc];
}

//==============================================================================
- (NSArray*) inputTraits
{
    return nil;
}

@end
