//
//  MUSectionWritable.m
//  MUKitTest
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionWritable.h"
#import "MUCellDataMaped.h"

@implementation MUSectionWritable

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [cells release];
    
    [super dealloc];
}

//==============================================================================
- (void) createCells
{
}

//==============================================================================
- (void) hideCellByIndex:(NSUInteger)anIndex
{
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(!cellData.visible)
        return;
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
    
    [visibleCellDataSource removeObjectAtIndex:index];
    [cells removeObjectAtIndex:index];
    cellData.visible = NO;
}

//==============================================================================
- (void) showCellByIndex:(NSUInteger)anIndex
{
}

//==============================================================================
- (void) mapFromObject
{
    for (MUCellData* cellData in cellDataSource)
    {
        [(MUCellDataMaped*)cellData mapFromObject];
    }
}

//==============================================================================
- (void) mapToObject
{
    for (MUCellData* cellData in cellDataSource)
    {
        [(MUCellDataMaped*)cellData mapToObject];
    }
}

@end
