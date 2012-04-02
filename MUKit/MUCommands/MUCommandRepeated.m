//
//  MUCommandRepeated.m
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommandRepeated.h"

@implementation MUCommandRepeated

@synthesize repeatCount;
@synthesize currentRepetitionIndex;

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        repeatCount = 1;
        currentRepetitionIndex = 0;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [callback release];
    
    [super dealloc];
}

// Don't override this method in your subclasses !
//==============================================================================
- (void) executeWithCallback:(MUCommandCallback)aCallback
{
    if(isExecution)
        return;
    
    isExecution = YES;
    currentRepetitionIndex = 0;
    
    callback = [aCallback copy];

    // prepare callback
//    MURepeatedTaskCallback taskCallback = ^(BOOL needRepeat, BOOL taskSuccess)
//    {
//        currentRepetitionIndex++;
//        
//        if(!needRepeat || currentRepetitionIndex == repeatCount)
//        {
//            isExecution = NO;
//            aCallback(taskSuccess);
//        }
//        else
//        {
//            [self repeatTask:taskCallback];
//        }
//    };

    // execute task
    [self repeatTask];
    
}

//==============================================================================
- (void) repeatTask//:(MURepeatedTaskCallback)repeatedTaskCallback
{
    NSAssert(NO, @"You need override this method!");
}

//==============================================================================
- (void) taskCompletedNeedRepeat:(BOOL)aNeedRepeat result:(BOOL)aTaskSuccess
{
    currentRepetitionIndex++;
    
    if(!aNeedRepeat || currentRepetitionIndex == repeatCount)
    {
        isExecution = NO;
        callback(aTaskSuccess);
        
        [callback release];
        callback = nil;
    }
    else
    {
        [self repeatTask];
    }
}


@end
