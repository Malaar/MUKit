//
//  MUSectionWritable.m
//  MUKit
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionWritable.h"
#import "MUCellDataMaped.h"
#import "MUCellData.h"
#import "MUCellProtocol.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUSectionWritable ()

- (MUCell*) createCellAtIndex:(NSUInteger)anIndex;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUSectionWritable

#pragma mark - Init/Dealloc
//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        cells = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [cells release];
    
    [super dealloc];
}

#pragma mark - Cells
//==============================================================================
- (void) createCells
{
    [self updateCellDataVisibility];
    [cells removeAllObjects];
    
    NSUInteger index = 0;
    MUCell* cell;
    for(MUCellData* cellData in visibleCellDataSource)
    {
        cell = [self createCellAtIndex:index++];
        [cells addObject:cell];
    }
}

//==============================================================================
- (UITableViewCell<MUCellProtocol>*) cellForIndex:(NSUInteger)anIndex inTable:(UITableView*)aTableView
{
    UITableViewCell<MUCellProtocol>* cell = [cells objectAtIndex:anIndex];
    // ...
    return cell;
}

#pragma mark - Show/Hide cels
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
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(cellData.visible)
        return;

    cellData.visible = YES;
    [self updateCellDataVisibility];
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
    MUCell* cell = [self createCellAtIndex:index];
    [cells insertObject:cell atIndex:index];
}

#pragma mark - Maping
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

#pragma mark - Private
//==============================================================================
- (MUCell*) createCellAtIndex:(NSUInteger)anIndex
{
    MUCellData* cellData = [self visibleCellDataAtIndex:anIndex];
    MUCell* cell = [[[cellData.cellClass alloc] initWithStyle:cellData.cellStyle reuseIdentifier:cellData.cellIdentifier] autorelease];
    
    [cell setupCellData:cellData];
    
    return cell;
}

@end
