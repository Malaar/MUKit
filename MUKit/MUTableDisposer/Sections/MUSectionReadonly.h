//
//  MUSectionReadonly.h
//  MUKitTest
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUCell.h"

@class MUCellData;

@interface MUSectionReadonly : NSObject
{
    NSMutableArray* cellDataSource;
    NSMutableArray* visibleCellDataSource;
}

@property (nonatomic, retain) NSString* headerTitle;
@property (nonatomic, retain) NSString* footerTitle;
@property (nonatomic, retain) UIView* headerView;
@property (nonatomic, retain) UIView* footerView;

+ (MUSectionReadonly*) section;

- (void) addCellData:(MUCellData*)aCellData;
- (void) addCellDataFromArray:(NSArray*)aCellDataArray;
- (void) insertCellData:(MUCellData*)aCellData atIndex:(NSUInteger)anIndex;
- (void) removeCellDataAtIndex:(NSUInteger)anIndex;
- (void) removeAllCellData;

- (MUCellData*) cellDataAtIndex:(NSUInteger)anIndex;
- (MUCellData*) visibleCellDataAtIndex:(NSUInteger)anIndex;
- (NSUInteger) indexByCellData:(MUCellData*)aCellData;
- (NSUInteger) indexByVisibleCellData:(MUCellData*)aCellData;

- (void) updateCellDataVisibility;

- (MUCell*) cellForIndex:(NSUInteger)anIndex inTable:(UITableView*)aTableView;

@end
