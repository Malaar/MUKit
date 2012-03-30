//
//  MUTableDisposer.h
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUSectionWritable.h"

@protocol MUTableDisposerDelegate <UITableViewDataSource, UITableViewDelegate>

@end

@interface MUTableDisposer : NSObject <UITableViewDataSource>
{
    UITableView* tableView;
    NSMutableArray* sections;
    id<MUTableDisposerDelegate> delegate;
}

@property (nonatomic, assign) Class tableClass;
@property (nonatomic, assign) UITableViewStyle tableStyle;
@property (nonatomic, readonly) UITableView* tableView;
@property (nonatomic, assign) id<MUTableDisposerDelegate> delegate;

- (void) addSection:(MUSectionReadonly*)aSection;
- (void) removeSectionAtIndex:(NSUInteger)anIndex;
- (void) removeSection:(MUSectionReadonly*)aSection;
- (void) removeAllSections;
- (MUSectionReadonly*) sectionByIndex:(NSUInteger)anIndex;
- (NSUInteger) indexBySection:(MUSectionReadonly*)aSection;

- (NSIndexPath*) indexPathByCellData:(MUCellData*)aCellData;
- (NSIndexPath*) indexPathByVisibleCellData:(MUCellData*)aCellData;

- (void) hideCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) showCellByIndexPath:(NSIndexPath*)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable;

@end
