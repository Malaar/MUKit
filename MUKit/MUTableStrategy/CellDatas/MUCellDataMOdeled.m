//
//  MUCellDataMOdeled.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMOdeled.h"

@implementation MUCellDataMOdeled

//==============================================================================
@synthesize model;

//==============================================================================
- (id) initWithModel:(id)aModel
{
    self = [super init];
    if (self)
    {
        model = [aModel retain];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [model release];    
    [super dealloc];
}

@end
