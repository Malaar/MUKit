//
//  MUTLBaseTableController.m
//  MUKit
//
//  Created by Malaar on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUBaseTableController.h"

@implementation MUBaseTableController

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        // ...
        dataSource = [NSMutableArray new];
    }
    
    return self;
}

//==============================================================================
- (void)dealloc
{
    [dataSource release];
    
    [super dealloc];
}

#pragma mark - View lifecycle
//==============================================================================
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
	Class tableViewClass = [self tableViewClass];
    if (!tableView)
    {
        tableView = [[[tableViewClass alloc] initWithFrame:self.view.bounds style:[self getTableViewStyle]] autorelease];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [tableView setBackgroundColor:[UIColor clearColor]];
    }
    
    [self.view addSubview:tableView];
}

//==============================================================================
- (void)viewDidUnload
{
    tableView = nil;
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - dataSource
//==============================================================================
- (BOOL) isDataSourceAvailable
{
    return [dataSource count];
}

#pragma mark - table
//==============================================================================
- (Class) tableViewClass
{
	return [UITableView class];
}

//==============================================================================
/**
 * Override this to change style of your table
 */
- (UITableViewStyle) getTableViewStyle
{
    return UITableViewStylePlain;
}

//==============================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // override this method in subclasses
    return [dataSource count];
}

//==============================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // override this method in subclasses
    return nil;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
