//
//  MUGatewayTask.m
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGatewayTask.h"
#import "MUGateway.h"


@implementation MUGatewayTask

@synthesize gateway;
@synthesize operation;

//==============================================================================
+ (id) taskWithGateway:(MUGateway*)aGateway operation:(AFHTTPRequestOperation*)anOperation
{
    return [[[MUGatewayTask alloc] initWithGateway:aGateway operation:anOperation] autorelease];
}

//==============================================================================
- (id) init
{
    [self release];
    return nil;
}

//==============================================================================
- (id) initWithGateway:(MUGateway*)aGateway operation:(AFHTTPRequestOperation*)anOperation
{
    if( (self = [super init]) )
    {
        gateway = aGateway;
        operation = anOperation;
    }
    return self;
}

//==============================================================================
- (void) cancel
{
    [operation cancel];
}

@end
