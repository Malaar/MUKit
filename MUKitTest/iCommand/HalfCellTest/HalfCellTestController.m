//
//  HalfCellTestController.m
//  MUKit
//
//  Created by Yuriy Bosov on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HalfCellTestController.h"

@implementation HalfCellTestController

//==============================================================================
- (id)init
{
    self = [super initWithNibName:@"HalfCellTestController" bundle:nil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
//==============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
}

//==============================================================================
- (void)viewDidUnload
{
    [super viewDidUnload];
}

//==============================================================================
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
