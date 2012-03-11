//
//  MULogger.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MULogMessage.h"
#import "MULogConsumer.h"


//==============================================================================
@interface MULogManager : NSObject
{
    NSArray* consumers;
    
    NSMutableArray* messagesBuffer;
}

+ (MULogManager*)sharedInstance;

- (void) configureWithConsumers:(NSArray*)aConsumers;

- (void) logMessageWithType:(MULogMessageType)aLogMessageType format:(NSString*)aFormattedText, ...;
- (void) logMessageWithType:(MULogMessageType)aLogMessageType format:(NSString*)aFormattedText arguments:(va_list) args;

@end