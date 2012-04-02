//
//  MUCommand.m
//  AlarmButton
//
//  Created by Malaar on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommand.h"

@implementation MUCommand : NSObject

@synthesize isExecution;

//==============================================================================
- (void) executeWithCallback:(MUCommandCallback)aCallback
{
    NSAssert(NO, @"You need override this method!");
}

@end
