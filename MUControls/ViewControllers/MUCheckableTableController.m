//
//  MUFilterTableController.m
//  TimeLink
//
//  Created by Malaar on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCheckableTableController.h"
#import "MUTitledID.h"


@implementation MUCheckableData

@synthesize dataSource;
@synthesize selectedIndex;

#pragma mark - Init/Dealloc
//==============================================================================
+ (id) checkableDataWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex
{
    return [[[MUCheckableData alloc] initWithDataSource:aDataSource selectedIndex:aSelectedIndex] autorelease];
}

//==============================================================================
- (id) initWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex
{
    if( (self = [super init]) )
    {
        selectedIndex = aSelectedIndex;
        self.dataSource = aDataSource;
    }
    return self;
}

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        selectedIndex = -1;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    self.dataSource = nil;
//    [dataSource release];
    
    [super dealloc];
}

//==============================================================================
- (NSObject*) selectedObject
{
    NSObject* result = nil;
    if(selectedIndex >= 0 && selectedIndex < [dataSource count])
        result = [dataSource objectAtIndex: selectedIndex];
    
    return result;
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCheckableTableController

@synthesize delegate;
@synthesize closeWhenSelected;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithCheckableData:(MUCheckableData*) aCheckableData title:(NSString*)aTitle
{
    if( (self = [super init]) )
    {
        selectedIndex = aCheckableData.selectedIndex;
        dataSource = [[NSMutableArray arrayWithArray:aCheckableData.dataSource] retain];
        checkableData = [aCheckableData retain];

        self.navigationItem.title = aTitle;
    }
    
    return self;
}

//==============================================================================
- (void)dealloc
{
    [checkableData release];
    
    [super dealloc];
}

//==============================================================================
- (UIBarButtonItem*) createLeftNavButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:nil action:nil];
}

//==============================================================================
- (UIBarButtonItem*) createRightNavButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:nil action:nil];
}

//==============================================================================
- (void) leftNavButtonPressed:(id)aSender
{
    if([delegate shouldCancelCheckableTableController:self])
        [delegate canceledCheckableTableController:self];
}

//==============================================================================
- (void) rightNavButtonPressed:(id)aSender
{
    // apply changes at selectedIndex
    checkableData.selectedIndex = selectedIndex;
    [delegate checkableTableController:self completeSelectionWithCheckableData:checkableData];
}

#pragma mark - Table
//==============================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

//==============================================================================
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell
    static NSString* cellIdentifier = @"FilterCell";
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }

    // select
    if(selectedIndex == [indexPath row])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        prevSelectedCell = cell;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    // title
    NSObject* object = [dataSource objectAtIndex:[indexPath row]];
    if([object isKindOfClass:[MUTitledID class]])
        cell.textLabel.text = ((MUTitledID*)object).title;
    else if([object isKindOfClass:[NSString class]])
        cell.textLabel.text = (NSString*)object;
    else
    {
        NSAssert(NO, @"Wrong type of object !!!");
    }
    
    return cell;
}

//==============================================================================
- (void) tableView:(UITableView*)aTableView didSelectRowAtIndexPath:indexPath
{
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];

    if(selectedIndex != [indexPath row])
    {
        selectedIndex = [indexPath row];
        UITableViewCell* cell = [aTableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

        prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        prevSelectedCell = cell;
    }
    
    if(!multipleSelection && closeWhenSelected)
    {
        checkableData.selectedIndex = selectedIndex;
        [delegate checkableTableController:self completeSelectionWithCheckableData:checkableData];
    }

}

//==============================================================================
//==============================================================================
//==============================================================================
@end
