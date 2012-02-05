//
//  MUPair.m
//  MUKit
//
//  Created by Malaar on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPair.h"


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUPair

@synthesize first;
@synthesize second;

//==============================================================================
+ (id) pairWithFirst:(NSObject*)aFirst second:(NSObject*)aSecond
{
    return [[[MUPair alloc] initWithFirst:aFirst second:aSecond] autorelease];
}

//==============================================================================
- (id) initWithFirst:(NSObject*)aFirst second:(NSObject*)aSecond
{
    if( (self = [super init]) )
    {
        self.first = aFirst;
        self.second = aSecond;
    }
    
    return self;
}

//==============================================================================
- (void) dealloc
{
    [first release];
    [second release];
    
    [super dealloc];
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation NSArray (MUPair)

//==============================================================================
- (MUPair*) pairByFirst:(NSObject*)aFirst
{
    MUPair* result = nil;
    for(MUPair* pair in self)
    {
        if([pair.first isEqual:aFirst])
        {
            result = pair;
            break;
        }
    }
    return result;
}

//==============================================================================
- (MUPair*) pairBySecond:(NSObject*)aSecond
{
    MUPair* result = nil;
    for(MUPair* pair in self)
    {
        if([pair.second isEqual:aSecond])
        {
            result = pair;
            break;
        }
    }
    return result;
}


//==============================================================================
//==============================================================================
//==============================================================================
@end