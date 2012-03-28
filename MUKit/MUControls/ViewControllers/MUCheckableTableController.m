//
//  MUFilterTableController.m
//  TimeLink
//
//  Created by Malaar on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCheckableTableController.h"
#import "MUKitDefines.h"


@implementation MUCheckableData

@synthesize dataSource;
@synthesize selectedIndex;

#pragma mark - Init/Dealloc
//==============================================================================
+ (id) checkableDataWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex titleKey:(NSString*)aTitleKey
{
    return [[[MUCheckableData alloc] initWithDataSource:aDataSource selectedIndex:aSelectedIndex titleKey:aTitleKey] autorelease];
}

//==============================================================================
- (id) initWithDataSource:(NSArray*)aDataSource selectedIndex:(NSInteger)aSelectedIndex titleKey:(NSString*)aTitleKey
{
    if( (self = [super init]) )
    {
        titleKey = [aTitleKey retain];
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
    [titleKey release];
    [dataSource release];
    
    [super dealloc];
}

//==============================================================================
- (NSString*) titleAtIndex:(NSInteger)anIndex
{
    MU_CHECK_INDEX(anIndex, 0, [dataSource count]);
    return [[dataSource objectAtIndex:anIndex] valueForKeyPath:titleKey];
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
@interface MUCheckableTableController ()

- (void) selectionCompleted;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCheckableTableController

@synthesize delegate;
@synthesize closeWhenSelected;
@synthesize showCancelButton;

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
    UIBarButtonItem *bbi = nil; 
    if (self.showCancelButton)
        bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:nil action:nil];
    return bbi;
}

//==============================================================================
- (UIBarButtonItem*) createRightNavButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:nil action:nil];
}

//==============================================================================
- (void) leftNavButtonPressed:(id)aSender
{
    [self dismissModalViewControllerAnimated:YES];
    if([delegate respondsToSelector:@selector(didCanceledCheckableTableController:)])
        [delegate didCanceledCheckableTableController:self];
}

//==============================================================================
- (void) rightNavButtonPressed:(id)aSender
{
    if(selectedIndex != -1)
    {
        // apply changes at selectedIndex
        [self selectionCompleted];
    }
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
    cell.textLabel.text = [checkableData titleAtIndex:indexPath.row];
    
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
}

//==============================================================================
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!multipleSelection && closeWhenSelected)
    {
        [self selectionCompleted];
    }
}

//==============================================================================
- (void) selectionCompleted
{
    checkableData.selectedIndex = selectedIndex;
    [self dismissModalViewControllerAnimated:YES];
    [delegate checkableTableController:self completeSelectionWithCheckableData:checkableData];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
