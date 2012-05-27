//
//  MUTableDisposerMaped.m
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerMaped.h"
#import "MUCellDataMaped.h"
#import "MUCell.h"

@implementation MUTableDisposerMaped

//==============================================================================
- (void) mapFromObject
{
    for(MUSectionReadonly* section in sections)
    {
        if([section isKindOfClass:[MUSectionWritable class]])
        {
            [(MUSectionWritable*)section mapFromObject];
        }
    }
}

//==============================================================================
- (void) mapToObject
{
    for(MUSectionReadonly* section in sections)
    {
        if([section isKindOfClass:[MUSectionWritable class]])
        {
            [(MUSectionWritable*)section mapToObject];
        }
    }
}

//==============================================================================
- (void) reloadData
{
    [self mapFromObject];
    [super reloadData];
}

//==============================================================================
- (void) reloadRowsAtIndexPaths:(NSArray *)anIndexPaths withRowAnimation:(UITableViewRowAnimation)aRowAnimation
{
    MUCellDataMaped* cellData;
    MUCell* cell;
    for(NSIndexPath* indexPath in anIndexPaths)
    {
        cellData = (MUCellDataMaped*)[self visibleCellDataByIndexPath:indexPath];
        [cellData mapFromObject];
        cell = (MUCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell setupCellData:cellData];
    }
    
    [self.tableView reloadRowsAtIndexPaths:anIndexPaths withRowAnimation:aRowAnimation];
}


@end
