//
//  MULogSystem.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MULogger_MULogSystem_h
#define MULogger_MULogSystem_h

#import "MULogManager.h"
// consumers
#import "MULogConsumerFile.h"

// formatters
#import "MULogFormatterPlainText.h"



/**
 `MULogger` is a set of functions that could be invoced for logging info to different consumers (like files etc).
 
 */

///-------------------------------
/// @name Logger's functions
///-------------------------------

/**
 Logging text with _info_ type.
 */
void MULogInfo(NSString* format, ...);

/**
 Logging text with _debug_ type.
 */
void MULogDebug(NSString* format, ...);

/**
 Logging text with _warning_ type.
 */
void MULogWarning(NSString* format, ...);

/**
 Logging text with _error_ type.
 */
void MULogError(NSString* format, ...);

/**
 Logging text with _fatal error_ type.
 */
void MULogFatal(NSString* format, ...);

#endif
