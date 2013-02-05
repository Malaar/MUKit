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
    [footerTitle release];
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
- (MUCellData*) cellDataByTag:(NSUInteger)aTag
{
    MUCellData* result = nil;
    for(MUCellData* cd in cellDataSource)
    {
        if(cd.tag == aTag)
        {
            result = cd;
            break;
        }
    }
    return result;
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
- (void) deleteRowsAtIndexes:(NSArray*)anIndexes withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    NSMutableArray* toDelete = [NSMutableArray array];
    MUCellData* cellData;
    for(NSNumber* index in anIndexes)
    {
        cellData = [self cellDataAtIndex:[index intValue]];
        [toDelete addObject:cellData];
    }
    
    [cellDataSource removeObjectsInArray:toDelete];
    [self updateCellDataVisibility];

    NSMutableArray* indexPaths = [NSMutableArray array];
    NSIndexPath* indexPath;
    NSInteger sectionIndex = [disposer indexBySection:self];
    for(NSNumber* index in anIndexes)
    {
        indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:sectionIndex];
        [indexPaths addObject:indexPath];
    }
    [disposer.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:aRowAnimation];
}

#pragma mark - Show/Hide cels
//==============================================================================
- (void) hideCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    [self hideCellByIndex:anIndex needUpdateTable:aNeedUpdateTable withAnimation:UITableViewRowAnimationMiddle];
}

//==============================================================================
- (void) showCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    [self showCellByIndex:anIndex needUpdateTable:aNeedUpdateTable withAnimation:UITableViewRowAnimationMiddle];
}

//==============================================================================
- (void) hideCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(!cellData.visible)
        return;
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
    
    [visibleCellDataSource removeObjectAtIndex:index];
//    [cells removeObjectAtIndex:index];
    cellData.visible = NO;
    
    if(aNeedUpdateTable)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:[disposer indexBySection:self]];
        [disposer.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:aRowAnimation];
    }
}

//==============================================================================
- (void) showCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(cellData.visible)
        return;
    
    cellData.visible = YES;
    [self updateCellDataVisibility];
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
//    MUCell* cell = [self createCellAtIndex:index];
//    [cells insertObject:cell atIndex:index];
    
    if(aNeedUpdateTable)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:[disposer indexBySection:self]];
        [disposer.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:aRowAnimation];
    }
}

@end
