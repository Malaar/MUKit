//
//  MULogConsumer.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MULogFormatter.h"

@interface MULogConsumer : NSObject
{
    NSObject<MULogFormatter>* formatter;
}

@property (nonatomic, readonly) NSObject<MULogFormatter>* formatter;

+ (id) consumerWithFormatter:(NSObject<MULogFormatter>*)aLogFormatter;
- (id) initWithFormatter:(NSObject<MULogFormatter>*)aLogFormatter;
- (void) consumeMessages:(NSArray*)aMessages;

@end
