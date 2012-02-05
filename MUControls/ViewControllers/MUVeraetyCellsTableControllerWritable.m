//
//  MUVeraetyCellsTableControllerWritable.m
//  MUKit
//
//  Created by Yuriy Bosov on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUVeraetyCellsTableControllerWritable.h"
#import "MUTableViewCell2Half.h"

//==============================================================================
@interface MUVeraetyCellsTableControllerWritable (Private)

- (void) createCells;

@end

//==============================================================================
@implementation MUVeraetyCellsTableControllerWritable

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        cells = nil;
    }
    
    return self;
}

//==============================================================================
- (void)dealloc
{
    [cells release];
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
- (void)loadView
{
    [super loadView];
}

//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCells];
}

//==============================================================================
- (void)viewDidUnload
{
    cells = [[NSMutableArray alloc] init];
    cells = nil;
    
    [super viewDidUnload];
}

#pragma mark - Table
//==============================================================================
- (void) createCells
{
    cells = [[NSMutableArray alloc] init];
    
    id cell = nil;
    Class cellClass;    
    MUTableViewCell2HalfData* cellData = nil;
    
    for (int i = 0; i < [cellDataSource count]; i++)
    {
        if ([[cellDataSource objectAtIndex:i] isKindOfClass:[MUTableViewCell2HalfData class]])
        {
            cellData = (MUTableViewCell2HalfData*)[cellDataSource objectAtIndex:i];
            cellClass = cellData.cellClass;
            cell = [[[cellClass alloc] initWithReuseIdentifier:[cellClass cellIdentifier] cellData:cellData forWidth:tableView.frame.size.width] autorelease];
            
            [cells addObject: cell];
        }
        else
        {
            NSAssert(nil,@"cellDataSource содержит объекты не того класса, что нужно. См. ф-ю createCellDataSource");
        }
    }
    
    [self didCreateCells];
}

//==============================================================================
- (void) didCreateCells
{
    // override this method in subclasses
}

//==============================================================================
- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUTableViewCell2Half* cell = nil;
    if ([cells count])
        cell = [cells objectAtIndex:indexPath.row];
    
    if (resizedWithAnimation)
    {
        [cell updateSizeFotWidth:tableView.frame.size.width animationTime:animationTime];
    }
    else
    {
        [cell updateSizeFotWidth:tableView.frame.size.width];
    }
    return cell;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
