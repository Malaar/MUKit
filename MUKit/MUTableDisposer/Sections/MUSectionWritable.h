//
//  MUSectionWritable.h
//  MUKit
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionReadonly.h"

@interface MUSectionWritable : MUSectionReadonly
{
    NSMutableArray* cells;
}

- (void) createCells;

- (void) hideCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable;
- (void) showCellByIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable;

- (void) mapFromObject;
- (void) mapToObject;

@end
