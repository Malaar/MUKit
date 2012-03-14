//
//  MUTargetAction.m
//  MUKitMaster
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTargetAction.h"


@implementation MUTargetAction

@synthesize target;
@synthesize action;

//==============================================================================
+ (id) targetActionWithTarget:(id)aTarget action:(SEL)anAction
{
    return [[[MUTargetAction alloc] initWithTarget:aTarget action:anAction] autorelease];
}

//==============================================================================
- (id) initWithTarget:(id)aTarget action:(SEL)anAction
{
    if( (self = [super init]) )
    {
        [self setTarget:aTarget action:anAction];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    if([target isKindOfClass:[MUWeakRef class]])
        [target release];
    
    [super dealloc];
}

//==============================================================================
- (void) setTarget:(id)aTarget action:(SEL)anAction
{
    if([aTarget isKindOfClass:[MUWeakRef class]])
        target = [aTarget retain];
    else
        target = aTarget;

    action = anAction;
}

//==============================================================================
- (void) sendActionFrom:(NSObject*)aSender
{
    id receiver = nil;
    
    if([target isKindOfClass:[MUWeakRef class]])
        receiver = ((MUWeakRef*)target).object;
    else
        receiver = target;
    
    if(receiver && [receiver respondsToSelector:action])
    {
        [receiver performSelector:action withObject:aSender];
    }
}

@end
