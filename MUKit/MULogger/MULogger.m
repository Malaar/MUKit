//
//  MULogSystem.c
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "MULogger.h"
#import <Foundation/Foundation.h>

//==============================================================================
inline void MULogInfo(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    [[MULogManager sharedInstance] logMessageWithType:logMessageTypeInfo format:format arguments:args];
    va_end(args);
}

//==============================================================================
inline void MULogDebug(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    [[MULogManager sharedInstance] logMessageWithType:logMessageTypeDebug format:format arguments:args];
    va_end(args);
}

//==============================================================================
inline void MULogWarning(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    [[MULogManager sharedInstance] logMessageWithType:logMessageTypeWarning format:format arguments:args];
    va_end(args);
}

//==============================================================================
inline void MULogError(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    [[MULogManager sharedInstance] logMessageWithType:logMessageTypeError format:format arguments:args];
    va_end(args);
}

//==============================================================================
inline void MULogFatal(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    [[MULogManager sharedInstance] logMessageWithType:logMessageTypeFatal format:format arguments:args];
    va_end(args);
}
