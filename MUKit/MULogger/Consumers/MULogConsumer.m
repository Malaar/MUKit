//
//  MULogConsumer.m
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogConsumer.h"

@implementation MULogConsumer

@synthesize formatter;

//==============================================================================
+ (id) consumerWithFormatter:(NSObject<MULogFormatter>*)aLogFormatter
{
    return [[[[self class] alloc] initWithFormatter:aLogFormatter] autorelease];
}

//==============================================================================
- (id) init
{
    [self release];
    return nil;
}

//==============================================================================
- (id) initWithFormatter:(NSObject<MULogFormatter>*)aLogFormatter
{
    if( (self = [super init]) )
    {
        formatter = [aLogFormatter retain];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [formatter release];
    
    [super dealloc];
}

//==============================================================================
- (void) consumeMessages:(NSArray*)aMessages
{
    NSAssert(NO, @"Owerride this method in subclasses!");
}

@end
