//
//  MUTableDisposer.m
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposer.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTableDisposer ()

- (UITableView*) createTableView;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTableDisposer

@synthesize tableClass;
@synthesize tableStyle;
@synthesize tableView;
@synthesize delegate;

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        sections = [NSMutableArray new];
        tableClass = [UITableView class];
        tableStyle = UITableViewStylePlain;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [sections release];
    [tableView release];
    
    [super dealloc];
}

//==============================================================================
- (UITableView*)tableView
{
    if(!tableView)
    {
        tableView = [self createTableView];
    }
    return tableView;
}

//==============================================================================
- (UITableView*) createTableView
{
    UITableView* tv = [[tableClass alloc] initWithFrame:CGRectZero style:tableStyle];
    tv.dataSource = self;
    tv.delegate = self;
    return tv;
}

//==============================================================================
- (void) releaseView
{
    [tableView release];
    tableView = nil;
}

//==============================================================================
- (void) addSection:(MUSectionReadonly*)aSection
{
    [sections addObject:aSection];
    [aSection setTableDisposer:self];
}

//==============================================================================
- (void) removeSectionAtIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    if(aNeedUpdateTable)
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:anIndex] withRowAnimation:UITableViewRowAnimationMiddle];

    [sections removeObjectAtIndex:anIndex];
}

//==============================================================================
- (void) removeSection:(MUSectionReadonly*)aSection needUpdateTable:(BOOL)aNeedUpdateTable
{
    NSUInteger index = [self indexBySection:aSection];
    [self removeSectionAtIndex:index needUpdateTable:aNeedUpdateTable];
}

//==============================================================================
- (void) removeAllSections
{
    [sections removeAllObjects];
}

//==============================================================================
- (MUSectionReadonly*) sectionByIndex:(NSUInteger)anIndex
{
    return [sections objectAtIndex:anIndex];
}

//==============================================================================
- (NSUInteger) indexBySection:(MUSectionReadonly*)aSection
{
    return [sections indexOfObject:aSection];
}

//==============================================================================
- (NSIndexPath*) indexPathByCellData:(MUCellData*)aCellData
{
    NSIndexPath* result = nil;
    
    NSUInteger rowIndex = NSNotFound;
    NSUInteger secIndex = 0;
    for(MUSectionReadonly* section in sections)
    {
        rowIndex = [section indexByCellData:aCellData];
        if(rowIndex != NSNotFound)
        {
            result = [NSIndexPath indexPathForRow:rowIndex inSection:secIndex];
        }
        secIndex++;
    }
    
    return result;
}

//==============================================================================
- (NSIndexPath*) indexPathByVisibleCellData:(MUCellData*)aCellData
{
    NSIndexPath* result = nil;
    
    NSUInteger rowIndex = NSNotFound;
    NSUInteger secIndex = 0;
    for(MUSectionReadonly* section in sections)
    {
        rowIndex = [section indexByVisibleCellData:aCellData];
        if(rowIndex != NSNotFound)
        {
            result = [NSIndexPath indexPathForRow:rowIndex inSection:secIndex];
        }
        secIndex++;
    }
    
    return result;
}

//==============================================================================
- (MUCellData*) cellDataByIndexPath:(NSIndexPath*)anIndexPath
{
    return [[self sectionByIndex:anIndexPath.section] cellDataAtIndex:anIndexPath.row];
}

//==============================================================================
- (void) hideCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUSectionReadonly* section = [self sectionByIndex:anIndexPath.section];
    if([section isKindOfClass:[MUSectionWritable class]])
    {
        [(MUSectionWritable*)section hideCellByIndex:anIndexPath.row needUpdateTable:aNeedUpdateTable];
    }
}

//==============================================================================
- (void) showCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUSectionReadonly* section = [self sectionByIndex:anIndexPath.section];
    if([section isKindOfClass:[MUSectionWritable class]])
    {
        [(MUSectionWritable*)section showCellByIndex:anIndexPath.row needUpdateTable:aNeedUpdateTable];
    }
}

#pragma mark - UITableViewDataSource
//==============================================================================
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sectionByIndex:section] visibleCellDataCount];
}

//==============================================================================
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self sectionByIndex:indexPath.section] cellForIndex:indexPath.row];
}

//==============================================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return [sections count];
}

//==============================================================================
- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return [self sectionByIndex:section].headerTitle;
}

//==============================================================================
- (NSString *)tableView:(UITableView *)aTableView titleForFooterInSection:(NSInteger)section
{
    return [self sectionByIndex:section].footerTitle;
}

//==============================================================================
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if(delegate && [delegate respondsToSelector:@selector(tableView: canEditRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView canEditRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (BOOL)tableView:(UITableView *)aTableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if(delegate && [delegate respondsToSelector:@selector(tableView: canMoveRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView canMoveRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    NSArray* result = nil;
    if(delegate && [delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)])
    {
        result = [delegate sectionIndexTitlesForTableView:aTableView];
    }
    return result;
}

//==============================================================================
- (NSInteger)tableView:(UITableView *)aTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger result = NSNotFound;
    if(delegate && [delegate respondsToSelector:@selector(tableView: sectionForSectionIndexTitle:atIndex:)])
    {
        result = [delegate tableView:aTableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return result;
}

//==============================================================================
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [delegate tableView:aTableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

//==============================================================================
- (void)tableView:(UITableView *)aTableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
    {
        [delegate tableView:aTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate
//==============================================================================
- (void)tableView:(UITableView *)aTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [delegate tableView:aTableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

//==============================================================================
- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData* cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    return [cellData cellHeightForWidth:aTableView.bounds.size.width];
}

//==============================================================================
- (CGFloat)tableView:(UITableView *)aTableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat result = 0;
    if([self sectionByIndex:section].headerView)
    {
        result = [self sectionByIndex:section].headerView.bounds.size.height;
    }
    else if([[self sectionByIndex:section].headerTitle length])
    {
        result = 20;
    }
    
//    return [self sectionByIndex:section].headerView ? [self sectionByIndex:section].headerView.bounds.size.height : 20;
    return result;
}

//==============================================================================
- (CGFloat)tableView:(UITableView *)aTableView heightForFooterInSection:(NSInteger)section
{
    CGFloat result = 0;
    if([self sectionByIndex:section].footerView)
    {
        result = [self sectionByIndex:section].footerView.bounds.size.height;
    }
    else if([[self sectionByIndex:section].footerTitle length])
    {
        result = 20;
    }
  
    return result;
//    return [self sectionByIndex:section].footerView ? [self sectionByIndex:section].footerView.bounds.size.height : 20;
}

//==============================================================================
- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionByIndex:section].headerView;
}

//==============================================================================
- (UIView *)tableView:(UITableView *)aTableView viewForFooterInSection:(NSInteger)section
{
    return [self sectionByIndex:section].footerView;
}

//==============================================================================
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData* cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    if(cellData)
    {
        [cellData performSelectedHandlers];
    }
    
    if(delegate && [delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [delegate tableView:aTableView didSelectRowAtIndexPath:indexPath];
    }
    
    if(cellData && cellData.autoDeselect)
    {
        [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//==============================================================================
- (void)tableView:(UITableView *)aTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData* cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    if(cellData)
    {
        [cellData performDeselectedHandlers];
    }
    
    if(delegate && [delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
    {
        [delegate tableView:aTableView didDeselectRowAtIndexPath:indexPath];
    }
}

//==============================================================================
//==============================================================================
//==============================================================================
//- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCellAccessoryType result = UITableViewCellAccessoryNone;
//    if(delegate && [delegate respondsToSelector:@selector(tableView: accessoryTypeForRowWithIndexPath:)])
//    {
//        result = [delegate tableView:aTableView accessoryTypeForRowWithIndexPath:indexPath];
//    }
//    return result;
//}

//==============================================================================
- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView: accessoryButtonTappedForRowWithIndexPath:)])
    {
        [delegate tableView:aTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

//==============================================================================
- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* result = indexPath;
    if(delegate && [delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView willSelectRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (NSIndexPath *)tableView:(UITableView *)aTableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* result = indexPath;
    if(delegate && [delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView willDeselectRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if(delegate && [delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView editingStyleForRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (NSString *)tableView:(UITableView *)aTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* result = nil;
    if(delegate && [delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (BOOL)tableView:(UITableView *)aTableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if(delegate && [delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (void)tableView:(UITableView*)aTableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)])
    {
        [delegate tableView:aTableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

//==============================================================================
- (void)tableView:(UITableView*)aTableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)])
    {
        [delegate tableView:aTableView didEndEditingRowAtIndexPath:indexPath];
    }
}

//==============================================================================
- (NSIndexPath *)tableView:(UITableView *)aTableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSIndexPath* result = nil;
    if(delegate && [delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
    {
        result = [delegate tableView:aTableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return result;
}

//==============================================================================
- (NSInteger)tableView:(UITableView *)aTableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger result = 0;
    if(delegate && [delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (BOOL)tableView:(UITableView *)aTableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if(delegate && [delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)])
    {
        result = [delegate tableView:aTableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return result;
}

//==============================================================================
- (BOOL)tableView:(UITableView *)aTableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    BOOL result = NO;
    if(delegate && [delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)])
    {
        result = [delegate tableView:aTableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return result;
}

//==============================================================================
- (void)tableView:(UITableView *)aTableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if(delegate && [delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)])
    {
        [delegate tableView:aTableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

//==============================================================================
- (void) reloadWithAnimation:(UITableViewRowAnimation)anAnimation
{
    for(MUSectionReadonly* section in sections)
    {
        [section reloadWithAnimation:anAnimation];
    }
}

//==============================================================================

@end
