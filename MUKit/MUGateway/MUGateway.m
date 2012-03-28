//
//  MUGateway.m
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGateway.h"


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUGateway

//==============================================================================
- (void) dealloc
{
    [httpClient release];
    
    [super dealloc];
}

//==============================================================================
- (void) configureHTTPClientWithBaseURL:(NSURL*)aBaseURL
{
    [httpClient release];
    httpClient = [[MUHTTPClient alloc] initWithBaseURL:aBaseURL];
}

//==============================================================================
- (void) httpRequestOperationDidEnqueue:(AFHTTPRequestOperation *)anOperation
{
    MUGatewayTask* task = [MUGatewayTask taskWithGateway:self operation:anOperation];
    startingTask = task;
}

//==============================================================================
//==============================================================================

@end
