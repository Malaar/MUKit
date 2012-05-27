//
//  MUSectionReadonly.m
//  MUKit
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionReadonly.h"
#import "MUTableDisposer.h"


@implementation MUSectionReadonly

@synthesize headerTitle;
@synthesize footerTitle;
@synthesize headerView;
@synthesize footerView;

#pragma mark - Init/Dealloc
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
- (void) setTableDisposer:(MUTableDisposer*)aTableDisposer
{
    disposer = aTableDisposer;
}

#pragma mark - CellDatas
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
- (NSUInteger) cellDataCount
{
    return [cellDataSource count];
}

//==============================================================================
- (NSUInteger) visibleCellDataCount
{
    return [visibleCellDataSource count];
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

#pragma mark - Cells
//==============================================================================
- (MUCell*) cellForIndex:(NSUInteger)anIndex
{
    MUCell* cell = nil;
    BOOL isNewCell = NO;
    
    MUCellData* cellData = [self visibleCellDataAtIndex:anIndex];
    
    cell = [disposer.tableView dequeueReusableCellWithIdentifier:cellData.cellIdentifier];
    
    if(!cell)
    {
        isNewCell = YES;
        cell = [cellData createCell];
    }

    [cell setupCellData:cellData];

    if(isNewCell && disposer.delegate && [disposer.delegate respondsToSelector:@selector(tableDisposer:didCreateCell:)])
        [disposer.delegate tableDisposer:disposer didCreateCell:cell];

    return cell;
}

//==============================================================================
- (void) reloadWithAnimation:(UITableViewRowAnimation)anAnimation
{
    [self updateCellDataVisibility];
    [disposer.tableView reloadSections:[NSIndexSet indexSetWithIndex:[disposer indexBySection:self]] withRowAnimation:anAnimation];
}

//==============================================================================
- (void) reloadRowsAtIndexes:(NSArray *)anIndexes withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    NSMutableArray* indexPaths = [NSMutableArray array];
    NSIndexPath* indexPath;
    NSInteger sectionIndex = [disposer indexBySection:self];
    for(NSNumber* index in anIndexes)
    {
        indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:sectionIndex];
        [indexPaths addObject:indexPath];
    }
    
    [disposer.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:aRowAnimation];
}

//==============================================================================

@end
