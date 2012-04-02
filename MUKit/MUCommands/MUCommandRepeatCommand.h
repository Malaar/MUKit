//
//  MUCommandRepeatCommand.h
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommand.h"

@interface MUCommandRepeatCommand : MUCommand

@property (nonatomic, readonly) MUCommand* command;

- (id) commandWithCommand:(MUCommand*)aCommand;
- (id) initWithCommand:(MUCommand*)aCommand;

@end
