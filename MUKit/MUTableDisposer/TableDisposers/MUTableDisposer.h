//
//  MUTableDisposer.h
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUSectionWritable.h"

//==============================================================================
@protocol MUTableDisposerDelegate <UITableViewDelegate>

@optional

- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)aTableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView;
- (NSInteger)tableView:(UITableView *)aTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)aTableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

- (void) tableDisposer:(MUTableDisposer*)aTableDisposer didCreateCell:(MUCell*)aCell;

@end

//==============================================================================
@interface MUTableDisposer : NSObject <UITableViewDataSource, UITableViewDelegate>
{
@protected
    UITableView* tableView;
    NSMutableArray* sections;
    id<MUTableDisposerDelegate> delegate;
}

@property (nonatomic, assign) Class tableClass;
@property (nonatomic, assign) UITableViewStyle tableStyle;
@property (nonatomic, readonly) UITableView* tableView;
@property (nonatomic, assign) id<MUTableDisposerDelegate> delegate;

- (void) releaseView;

- (void) addSection:(MUSectionReadonly*)aSection;
- (void) insertSection:(MUSectionReadonly*)aSection atIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) removeSectionAtIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) removeSection:(MUSectionReadonly*)aSection needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) removeAllSections;
- (MUSectionReadonly*) sectionByIndex:(NSUInteger)anIndex;
- (NSUInteger) indexBySection:(MUSectionReadonly*)aSection;
- (NSUInteger) sectionsCount;

- (NSIndexPath*) indexPathByCellData:(MUCellData*)aCellData;
- (NSIndexPath*) indexPathByVisibleCellData:(MUCellData*)aCellData;
- (MUCellData*) cellDataByIndexPath:(NSIndexPath*)anIndexPath;
- (MUCellData*) visibleCellDataByIndexPath:(NSIndexPath*)anIndexPath;

- (void) hideCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) showCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable;

- (void) deleteRowsAtIndexPaths:(NSArray*)anIndexPaths withRowAnimation:(UITableViewRowAnimation)aTableViewRowAnimation;

- (void) reloadData;
- (void) reloadSectionsWithAnimation:(UITableViewRowAnimation)anAnimation;

@end
