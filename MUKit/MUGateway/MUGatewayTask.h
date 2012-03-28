//
//  MUGatewayTask.h
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@class MUGateway;

@interface MUGatewayTask : NSObject

@property (nonatomic, readonly) MUGateway* gateway;
@property (nonatomic, readonly) AFHTTPRequestOperation* operation;

+ (id) taskWithGateway:(MUGateway*)aGateway operation:(AFHTTPRequestOperation*)anOperation;
- (id) initWithGateway:(MUGateway*)aGateway operation:(AFHTTPRequestOperation*)anOperation;

- (void) cancel;

@end
