//
//  MUHTTPClient.m
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUHTTPClient.h"
#import "MUGateway.h"


@implementation MUHTTPClient

@synthesize gatewayDelegate;

//==============================================================================
- (void) enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation
{
    [gatewayDelegate httpRequestOperationDidEnqueue:operation];
    [super enqueueHTTPRequestOperation:operation];
}

@end
