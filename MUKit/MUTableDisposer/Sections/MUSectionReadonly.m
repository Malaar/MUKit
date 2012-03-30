//
//  MUSectionReadonly.m
//  MUKitTest
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionReadonly.h"
#import "MUCellData.h"


@implementation MUSectionReadonly

@synthesize headerTitle;
@synthesize footerTitle;
@synthesize headerView;
@synthesize footerView;


//==============================================================================
+ (MUSectionReadonly*) section
{
    return [[[[self class] alloc] init] autorelease];
}

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        cellDataSource = [NSMutableArray new];
        visibleCellDataSource = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [headerView release];
    [footerView release];
    [headerTitle release];
    [footerView release];
    [cellDataSource release];
    [visibleCellDataSource release];
    
    [super dealloc];
}

//==============================================================================
- (void) addCellData:(MUCellData*)aCellData
{
    [cellDataSource addObject:aCellData];
}

//==============================================================================
- (void) addCellDataFromArray:(NSArray*)aCellDataArray
{
    [cellDataSource addObjectsFromArray:aCellDataArray];
}

//==============================================================================
- (void) insertCellData:(MUCellData*)aCellData atIndex:(NSUInteger)anIndex
{
    [cellDataSource insertObject:aCellData atIndex:anIndex];
}

//==============================================================================
- (void) removeCellDataAtIndex:(NSUInteger)anIndex
{
    [cellDataSource removeObjectAtIndex:anIndex];
}

//==============================================================================
- (void) removeAllCellData
{
    [cellDataSource removeAllObjects];
}

//==============================================================================
- (MUCellData*) cellDataAtIndex:(NSUInteger)anIndex
{
    return [cellDataSource objectAtIndex:anIndex];
}

//==============================================================================
- (MUCellData*) visibleCellDataAtIndex:(NSUInteger)anIndex
{
    return [visibleCellDataSource objectAtIndex:anIndex];
}

//==============================================================================
- (NSUInteger) indexByCellData:(MUCellData*)aCellData
{
    return [cellDataSource indexOfObject:aCellData];
}

//==============================================================================
- (NSUInteger) indexByVisibleCellData:(MUCellData*)aCellData
{
    return [visibleCellDataSource indexOfObject:aCellData];
}

//==============================================================================
- (void) updateCellDataVisibility
{
    [visibleCellDataSource removeAllObjects];
    for(MUCellData* cellData in cellDataSource)
    {
        if(cellData.visible)
            [visibleCellDataSource addObject:cellData];
    }
}

//==============================================================================
- (MUCell*) cellForIndex:(NSUInteger)anIndex inTable:(UITableView*)aTableView
{
    MUCell* cell = nil;
    
    MUCellData* cellData = [self visibleCellDataAtIndex:anIndex];
    
    cell = [aTableView dequeueReusableCellWithIdentifier:cellData.cellIdentifier];
    
    if(!cell)
    {
        cell = [[[cellData.cellClass alloc] initWithStyle:cellData.cellStyle reuseIdentifier:cellData.cellIdentifier] autorelease];
    }

    [cell setupCellData:cellData];
    
    return cell;
}

//==============================================================================

@end
