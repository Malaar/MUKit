//
//  MUCellDataMaped.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@implementation MUCellDataMaped


@synthesize key;
@synthesize object;

- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super init];
    if (self)
    {
        key = [aKey retain];
        object = aObject;
    }
    return self;
}

- (void) dealloc
{
    [key release];
    [super dealloc];
}

- (void) mapFromObject
{

}

- (void) mapToObject
{

}

@end
