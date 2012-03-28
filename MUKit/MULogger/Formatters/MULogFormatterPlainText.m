//
//  MULogFormatterPlainText.m
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogFormatterPlainText.h"


@implementation MULogFormatterPlainText

//==============================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        logDateFormatter = [NSDateFormatter new];
        [logDateFormatter setDateStyle:(NSDateFormatterShortStyle)];
        [logDateFormatter setTimeStyle:(NSDateFormatterMediumStyle)];
            
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [logDateFormatter release];
    [super dealloc];
}

//==============================================================================
- (NSData*) formatMessage:(MULogMessage*)aMessage
{
    return [[NSString stringWithFormat:@"(%@) %@ : %@\n", [logDateFormatter stringFromDate:aMessage.date], [aMessage typeDescription], [aMessage text]] dataUsingEncoding:NSUTF8StringEncoding];
}

@end
