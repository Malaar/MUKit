//
//  MUCellDataMaped.m
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@implementation MUCellDataMaped

//==============================================================================
@synthesize key;
@synthesize object;

//==============================================================================
- (id) init
{
    NSAssert(nil, @"You mast used initWithObject:key: method!");
    return nil;
}

//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super init];
    if (self)
    {
        key = [aKey retain];
        object = aObject;
        
        [self setup];
    }
    return self;
}

//==============================================================================
- (void) setup
{
    [self mapFromObject];
}

//==============================================================================
- (void) dealloc
{
    [key release];
    [super dealloc];
}

//==============================================================================
- (void) mapFromObject
{
    NSAssert(nil, @"Override this method in subclasses!");
}

//==============================================================================
- (void) mapToObject
{
    NSAssert(nil, @"Override this method in subclasses!");
}

@end
