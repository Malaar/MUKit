//
//  MUVeraetyCellsTableController.m
//  MUKit
//
//  Created by Malaar on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUVeraetyCellsTableControllerReadonly.h"
#import "MUTableViewCell2Half.h"

@implementation MUVeraetyCellsTableControllerReadonly

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        cellDataSource = [NSMutableArray new];
        
        animationTime = 0.f;
        resizedWithAnimation = NO;
    }
    
    return self;
}

//==============================================================================
- (void)dealloc
{
    [cellDataSource release];
    
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
    [self createCellDataSource];
}

//==============================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableView reloadData];
}

//==============================================================================
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    animationTime = duration;
    resizedWithAnimation = YES;
    [tableView reloadData];
}

//==============================================================================
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    resizedWithAnimation = NO;
}

#pragma mark - Table
//==============================================================================
- (void) createCellDataSource
{
    // override this method in subclasses
}

//==============================================================================
- (UITableViewStyle) getTableViewStyle
{
    return UITableViewStylePlain;
}

//==============================================================================
- (float) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[cellDataSource objectAtIndex:indexPath.row] heightCellForCellWidth:aTableView.frame.size.width];
}

//==============================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellDataSource count];
}

//==============================================================================
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class class = [[cellDataSource objectAtIndex:indexPath.row] cellClass];
    NSString* identifier = [class cellIdentifier];
    
    MUTableViewCell2Half* cell = (MUTableViewCell2Half*)[aTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)                //create cell
    {
        cell = [[[class alloc] initWithReuseIdentifier:identifier cellData:[cellDataSource objectAtIndex:indexPath.row] forWidth:tableView.frame.size.width] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if (resizedWithAnimation)  // resize cell on rotation
    {
        [cell updateCellData:[cellDataSource objectAtIndex:indexPath.row] forWidth:tableView.frame.size.width animationTime:animationTime];
    }
    else                            // update cell data
    {
        [cell updateCellData:[cellDataSource objectAtIndex:indexPath.row] fotWidth:tableView.frame.size.width];
    }
    
    return cell;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
