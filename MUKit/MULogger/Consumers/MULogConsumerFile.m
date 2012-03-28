//
//  MULogConsumerFile.m
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogConsumerFile.h"

@implementation MULogConsumerFile

@synthesize filePath;

//==============================================================================
- (void) dealloc
{
    [filePath release];
    
    [super dealloc];
}

//==============================================================================
- (void) consumeMessages:(NSArray*)aMessages
{
    if(!filePath)
    {
        NSAssert(NO, @"filePath is nil!!!");
        return;
    }
    NSMutableData* data = [NSMutableData data];
    
    for(MULogMessage* message in aMessages)
    {
        [data appendData:[formatter formatMessage:message]];
    }
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSFileHandle* fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    if(!fileHandle)
        return;

    BOOL needReplaceFile = false;
    
    if(needReplaceFile)
    {
        [fileHandle truncateFileAtOffset:0];
    }
    else
    {
        [fileHandle seekToEndOfFile];
    }
    
    [fileHandle writeData:data];
    
    [fileHandle closeFile];
}

@end
