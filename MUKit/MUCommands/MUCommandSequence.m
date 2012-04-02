//
//  MUCommandSequence.m
//  MUKit
//
//  Created by Malaar on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommandSequence.h"
#import "MUKitDefines.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCommandSequence (Private)

- (void) executeCommand:(MUCommand*)aCommand;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCommandSequence

@synthesize breakWhenFailure;

//==============================================================================
+ (id) commandWithCommands:(NSArray*)aCommands
{
    return [[[MUCommandSequence alloc] initWithCommands:aCommands] autorelease];
}

//==============================================================================
- (id) initWithCommands:(NSArray*)aCommands
{
    if( (self = [self init]) )
    {
        [commands addObjectsFromArray:aCommands];
        breakWhenFailure = YES;
    }
    return self;
}

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        commands = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [commands release];
    [callback release];
    
    [super dealloc];
}

//==============================================================================
- (void) addCommand:(MUCommand*)aCommand
{
    [commands addObject:aCommand];
}

//==============================================================================
- (MUCommand*) commandAtIndex:(NSInteger)anIndex
{
    MU_CHECK_INDEX(anIndex, 0, [commands count]);
    
    return [commands objectAtIndex:anIndex];
}

//==============================================================================
- (void) executeWithCallback:(MUCommandCallback)aCallback
{
    if(isExecution || [commands count] == 0)
        return;
    
    [callback release];
    callback = [aCallback copy];
    
    isExecution = YES;
    executionIndex = 0;
    MUCommand* cmd = [commands objectAtIndex:executionIndex];
    [self executeCommand:cmd];
}

//==============================================================================
- (void) executeCommand:(MUCommand*)aCommand
{
    [aCommand executeWithCallback:^(BOOL success)
    {
        if( (!success && breakWhenFailure) || executionIndex == [commands count] - 1)
        {
            isExecution = NO;
            callback(success);

            [callback release];
            callback = nil;
        }
        else
        {
            MUCommand* cmd = [commands objectAtIndex:++executionIndex];
            [self executeCommand:cmd];
        }
        
    }];
}

@end
