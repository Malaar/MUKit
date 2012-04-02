//
//  MUTargetAction.m
//  MUKitMaster
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTargetAction.h"


//==============================================================================
//==============================================================================
//==============================================================================
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
- (void) setTarget:(id)aTarget action:(SEL)anAction
{
    target = aTarget;
    action = anAction;
}

//==============================================================================
- (void) sendActionFrom:(NSObject*)aSender
{
    if(target && [target respondsToSelector:action])
    {
        [target performSelector:action withObject:aSender];
    }
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTargetActionList

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        taList = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void)dealloc
{
    [taList release];
    [super dealloc];
}

//==============================================================================
- (void) addTarget:(id)aTarget action:(SEL)anAction
{
    [taList addObject:[MUTargetAction targetActionWithTarget:aTarget action:anAction]];
}

//==============================================================================
- (void) sendActionsFrom:(NSObject*)aSender
{
    for(MUTargetAction* ta in taList)
    {
        [ta sendActionFrom:aSender];
    }
}

@end
