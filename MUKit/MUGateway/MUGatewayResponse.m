//
//  MUGatewayResponse.m
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGatewayResponse.h"

@implementation MUGatewayResponse

@synthesize responseCode, textMessage, dataDictionary, boArray;

//==============================================================================
- (id)init
{
    self = [super init];
    if(self)
    {
        dataDictionary = [NSMutableDictionary new];
        boArray = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [textMessage release];
    [dataDictionary release];
    [boArray release];
    
    [super dealloc];
}

@end
