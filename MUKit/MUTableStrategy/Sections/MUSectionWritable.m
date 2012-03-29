//
//  MUSectionWritable.m
//  MUKitTest
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionWritable.h"

@implementation MUSectionWritable

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [cells release];
    
    [super dealloc];
}

//==============================================================================
- (void) createCells
{
}

//==============================================================================
- (void) hideCellByIndex:(NSUInteger)anIndex
{
}

//==============================================================================
- (void) showCellByIndex:(NSUInteger)anIndex
{
}

//==============================================================================
- (void) mapFromObject
{
}

//==============================================================================
- (void) mapToObject
{
}

@end
