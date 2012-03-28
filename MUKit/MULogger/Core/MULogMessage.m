//
//  MULogMessage.m
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogMessage.h"


static NSString* types[] = {@"DEBUG", @"INFO", @"WARNING", @"ERROR", @"FATAL"};


@implementation MULogMessage

@synthesize type;
@synthesize date;
@synthesize text;

//==============================================================================
+ (id) logMessage
{
    return [[[MULogMessage alloc] init] autorelease];
}

//==============================================================================
+ (id) logMessageWithType:(MULogMessageType)aLogMessageType text:(NSString*)aText
{
    return [[[MULogMessage alloc] initWithType:aLogMessageType text:aText] autorelease];
}

//==============================================================================
- (id) init
{
    return [self initWithType:logMessageTypeDebug text:nil];
}

//==============================================================================
- (id) initWithType:(MULogMessageType)aLogMessageType text:(NSString*)aText
{
    if( (self = [super init]) )
    {
        type = aLogMessageType;
        self.text = aText;
        date = [[NSDate date] retain];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [text release];
    [date release];
    
    [super dealloc];
}

//==============================================================================
- (NSString*) typeDescription
{
    return types[(int)type];
}

@end
