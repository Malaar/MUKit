//
//  MULogger.m
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogManager.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MULogManager (Private)

- (void) addMessage:(MULogMessage*)aMessage;
- (BOOL) needFlushMessages;
- (void) flushMessages;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MULogManager

//==============================================================================
+ (MULogManager*)sharedInstance
{
    static MULogManager* sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^
                  {
                      sharedInstance = [[MULogManager alloc] init];
                  });
    
    return sharedInstance;
}

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        messagesBuffer = [[NSMutableArray alloc] init];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [consumers release];
    [messagesBuffer release];
    
    [super dealloc];
}

//==============================================================================
- (void) configureWithConsumers:(NSArray*)aConsumers
{
    if(consumers != aConsumers)
    {
        [consumers release];
        consumers = [aConsumers retain];
    }
}

//==============================================================================
- (void) logMessageWithType:(MULogMessageType)aLogMessageType format:(NSString*)aFormattedText, ...
{
    va_list args;
    va_start(args, aFormattedText);

    NSString* strText = [[NSString alloc] initWithFormat:aFormattedText arguments:args];
    MULogMessage* message = [MULogMessage logMessageWithType:aLogMessageType text:strText];
    [self addMessage:message];
    [strText release];
    va_end(args);
}

//==============================================================================
- (void) logMessageWithType:(MULogMessageType)aLogMessageType format:(NSString*)aFormattedText arguments:(va_list) args
{
    NSString* strText = [[NSString alloc] initWithFormat:aFormattedText arguments:args];
    MULogMessage* message = [MULogMessage logMessageWithType:aLogMessageType text:strText];
    [self addMessage:message];
    [strText release];
}

#pragma mark - Private
//==============================================================================
- (void) addMessage:(MULogMessage*)aMessage
{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ : %@", [aMessage typeDescription], [aMessage text]] );

    @synchronized(self)
    {
        [messagesBuffer addObject:aMessage];
        if( [self needFlushMessages] )
        {
            [self flushMessages];
        }
    }
}

//==============================================================================
- (BOOL) needFlushMessages
{
    return [messagesBuffer count] > 5 || ((MULogMessage*)[messagesBuffer lastObject]).type >= logMessageTypeError;
}

//==============================================================================
- (void) flushMessages
{
    for(MULogConsumer* consumer in consumers)
    {
        [consumer consumeMessages:messagesBuffer];
    }
    [messagesBuffer removeAllObjects];
}

@end
