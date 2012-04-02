//
//  TableViewWithMapedCells.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewWithMapedCells.h"

@implementation TableViewWithMapedCells

//==============================================================================
- (id)init
{
    self = [super init];
    if (self) 
    {
        self.title = @"TEST";
        tableDisposer = [[MUTableDisposerMaped alloc] init];
        tableDisposer.tableStyle = UITableViewStyleGrouped;
        tableDisposer.delegate = self;
    }
    return self;
}
#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview: tableDisposer.tableView];
    
    // create sections
//    MUSectionWritable
}

//==============================================================================
- (void)viewDidUnload
{
    [tableDisposer releaseView];
    [super viewDidUnload];
}

//==============================================================================
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tableDisposer.tableView.frame = self.view.bounds;
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
