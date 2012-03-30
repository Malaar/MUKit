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

- (void) hideCellByIndex:(NSUInteger)anIndex;
- (void) showCellByIndex:(NSUInteger)anIndex;

- (void) mapFromObject;
- (void) mapToObject;

@end
