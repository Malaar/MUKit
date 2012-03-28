//
//  MULogMessage.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MULogMessageType
{
    logMessageTypeDebug,
    logMessageTypeInfo,
    logMessageTypeWarning,
    logMessageTypeError,
    logMessageTypeFatal
    
} MULogMessageType;

@interface MULogMessage : NSObject
{
}

@property (nonatomic, assign) MULogMessageType type;
@property (nonatomic, readonly) NSDate* date;
@property (nonatomic, retain) NSString* text;

+ (id) logMessage;
+ (id) logMessageWithType:(MULogMessageType)aLogMessageType text:(NSString*)aText;
- (id) initWithType:(MULogMessageType)aLogMessageType text:(NSString*)aText;

- (NSString*) typeDescription;

@end
