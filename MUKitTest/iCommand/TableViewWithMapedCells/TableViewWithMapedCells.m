//
//  TableViewWithMapedCells.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewWithMapedCells.h"
#import "MUSectionWritable.h"

#import "MUCellDataSwitch.h"
#import "MUCellDataTextField.h"
#import "MUCellDataLabel.h"
#import "MUCellDataStandart.h"

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
    tableDisposer.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // new section
    MUSectionWritable *section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";
    [tableDisposer addSection:section];
    
    MUCellDataTextField *cellDataTextField = [[[MUCellDataTextField alloc] initWithObject:nil key:nil] autorelease];
    cellDataTextField.text = @"MUCellDataTextField";
    cellDataTextField.title = @"Text";
    [section addCellData: cellDataTextField];
    
    cellDataTextField = [[[MUCellDataTextField alloc] initWithObject:nil key:nil] autorelease];
    cellDataTextField.text = @"MUCellDataTextField";
    cellDataTextField.placeholder = @"please enter text";
    [section addCellData: cellDataTextField];
    
    MUCellDataSwitch *cellDataSwitch = [[MUCellDataSwitch alloc] initWithObject:nil key:nil];
    cellDataSwitch.title = @"Switch";
    cellDataSwitch.boolValue = YES;
    [section addCellData:cellDataSwitch];
    
    cellDataSwitch = [[MUCellDataSwitch alloc] initWithObject:nil key:nil];
    cellDataSwitch.subtitle = @"Switch";
    cellDataSwitch.boolValue = NO;
    [section addCellData:cellDataSwitch];
    
    // new section
    section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";
    [tableDisposer addSection:section];
    
    cellDataSwitch = [[MUCellDataSwitch alloc] initWithObject:nil key:nil];
    cellDataSwitch.title = @"Switch";
    cellDataSwitch.boolValue = YES;
    [section addCellData:cellDataSwitch];

    
    // new section
    section = [[[MUSectionWritable alloc] init] autorelease];
    section.headerTitle = @"Section title";    
    section.footerTitle = @"footerTitle";    
    [tableDisposer addSection:section];
    
    [tableDisposer mapFromObject];
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
