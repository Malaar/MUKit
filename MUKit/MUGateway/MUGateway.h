//
//  MUGateway.h
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUGatewayTask.h"
#import "MUHTTPClient.h"
#import "MUGatewayResponse.h"

typedef void(^MUGatewayCallback)(MUGatewayResponse* aResponse);

@interface MUGateway : NSObject
{
    MUHTTPClient* httpClient;
    
    MUGatewayTask* startingTask;
}

- (void) configureHTTPClientWithBaseURL:(NSURL*)aBaseURL;
- (void) httpRequestOperationDidEnqueue:(AFHTTPRequestOperation *)operation;

@end
