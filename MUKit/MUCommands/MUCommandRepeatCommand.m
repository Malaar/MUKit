//
//  MUCommandRepeatCommand.m
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommandRepeatCommand.h"

@implementation MUCommandRepeatCommand

@synthesize command;

//==============================================================================
- (id) commandWithCommand:(MUCommand*)aCommand
{
    return [[[MUCommandRepeatCommand alloc] initWithCommand:aCommand] autorelease];
}

//==============================================================================
- (id) initWithCommand:(MUCommand*)aCommand
{
    if( (self = [super init]) )
    {
        command = [aCommand retain];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [command release];
    
    [super dealloc];
}

//==============================================================================
- (void) executeWithCallback:(MUCommandCallback)aCallback
{
    
}

@end
