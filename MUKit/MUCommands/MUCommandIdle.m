//
//  MUCommandIdle.m
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommandIdle.h"
#import "MULogger.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCommandIdle (Private)

- (void) idleTimeCompleted:(NSTimeInterval)aTimeInterval;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCommandIdle

@synthesize idleTime;

//==============================================================================
+ (id) commandWithIdleTime:(NSTimeInterval) anIdleTime
{
    return [[[MUCommandIdle alloc] initWithIdleTime:anIdleTime] autorelease];
}

//==============================================================================
- (id) initWithIdleTime:(NSTimeInterval) anIdleTime
{
    if( (self = [super init]) )
    {
        idleTime = anIdleTime;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [callback release];
    
    [super dealloc];
}

//==============================================================================
- (void) executeWithCallback:(MUCommandCallback)aCallback
{
    [callback release];
    callback = [aCallback copy];

    MULogInfo(@"MUCommandIdle begin. idleTime: %0.2f", idleTime);

    [NSTimer scheduledTimerWithTimeInterval:idleTime target:self selector:@selector(idleTimeCompleted:) userInfo:nil repeats:NO];
}

//==============================================================================
- (void) idleTimeCompleted:(NSTimeInterval)aTimeInterval
{
    MULogInfo(@"MUCommandIdle end.");

    callback(YES);
    [callback release];
    callback = nil;
}

@end
