//
//  MUCommandIdle.h
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommand.h"

@interface MUCommandIdle : MUCommand
{
    MUCommandCallback callback;
}

@property (nonatomic, readonly) NSTimeInterval idleTime;

+ (id) commandWithIdleTime:(NSTimeInterval) anIdleTime;
- (id) initWithIdleTime:(NSTimeInterval) anIdleTime;

@end
