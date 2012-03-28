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

//==============================================================================
void MULogInfo(NSString* format, ...);
void MULogDebug(NSString* format, ...);
void MULogWarning(NSString* format, ...);
void MULogError(NSString* format, ...);
void MULogFatal(NSString* format, ...);

#endif
