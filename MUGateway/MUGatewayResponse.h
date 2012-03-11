//
//  MUGatewayResponse.h
//  MUGatewayTest
//
//  Created by Malaar on 11.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUGatewayResponse : NSObject

@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, retain) NSString* textMessage;
@property (nonatomic, readonly) NSMutableDictionary* dataDictionary;
@property (nonatomic, readonly) NSMutableArray* boArray;

@end
