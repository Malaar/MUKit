//
//  MUHTTPClient.h
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFNetworking.h"


@class MUGateway;

@interface MUHTTPClient : AFHTTPClient

@property (nonatomic, assign) MUGateway* gatewayDelegate;

@end
