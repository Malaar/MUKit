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
#import "MUTableDisposer.h"
#import "MUKeyboardAvoidingProtocol.h"


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
- (UITableViewCell<MUCellProtocol>*) cellForIndex:(NSUInteger)anIndex
{
    UITableViewCell<MUCellProtocol>* cell = [cells objectAtIndex:anIndex];
    // ...
    return cell;
}

//==============================================================================
- (void) reloadWithAnimation:(UITableViewRowAnimation)anAnimation
{
    [self mapFromObject];
    [super reloadWithAnimation:anAnimation];
}

//==============================================================================
- (void) reloadRowsAtIndexes:(NSArray *)anIndexes withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    NSMutableArray* indexPaths = [NSMutableArray array];
    NSIndexPath* indexPath;
    NSInteger sectionIndex = [disposer indexBySection:self];
    
    MUCellData* cellData;
    MUCell* cell;
    for(NSNumber* index in anIndexes)
    {
        cellData = [self cellDataAtIndex:[index integerValue]];
        if([cellData isKindOfClass:[MUCellDataMaped class]])
        {
            [(MUCellDataMaped*)cellData mapFromObject];
            cell = [self cellForIndex:[index integerValue]];
            [cell setupCellData:cellData];
        }
        indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:sectionIndex];
        [indexPaths addObject:indexPath];
    }
    
    [disposer.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:aRowAnimation];
}


#pragma mark - Show/Hide cels
//==============================================================================
- (void) hideCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(!cellData.visible)
        return;
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
    
    [visibleCellDataSource removeObjectAtIndex:index];
    [cells removeObjectAtIndex:index];
    cellData.visible = NO;
    
    if(aNeedUpdateTable)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:[disposer indexBySection:self]];
        [disposer.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

//==============================================================================
- (void) showCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUCellData* cellData = [self cellDataAtIndex:anIndex];
    if(cellData.visible)
        return;

    cellData.visible = YES;
    [self updateCellDataVisibility];
    
    NSUInteger index = [self indexByVisibleCellData:cellData];
    MUCell* cell = [self createCellAtIndex:index];
    [cells insertObject:cell atIndex:index];

    if(aNeedUpdateTable)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:[disposer indexBySection:self]];
        [disposer.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    for (MUCellData* cellData in cellDataSource)
    {
        if ([cellData isKindOfClass:[MUCellDataMaped class]])
            [(MUCellDataMaped*)cellData mapFromObject];
    }
    [self createCells];
}

//==============================================================================
- (void) mapToObject
{
    for (MUCellData* cellData in cellDataSource)
    {
        if ([cellData isKindOfClass:[MUCellDataMaped class]])
            [(MUCellDataMaped*)cellData mapToObject];
    }
}


#pragma mark - Private
//==============================================================================
- (MUCell*) createCellAtIndex:(NSUInteger)anIndex
{
    MUCellData* cellData = [self visibleCellDataAtIndex:anIndex];
    MUCell* cell = [cellData createCell];
    [cell setupCellData:cellData];
    
    if ([disposer.tableView conformsToProtocol:@protocol(MUKeyboardAvoidingProtocol)])
    {
        [((id<MUKeyboardAvoidingProtocol>)disposer.tableView) addObjectsForKeyboard:[cell inputTraits]];
    }
    
    if(disposer.delegate && [disposer.delegate respondsToSelector:@selector(tableDisposer:didCreateCell:)])
        [disposer.delegate tableDisposer:disposer didCreateCell:cell];
    
    
    return cell;
}

@end
