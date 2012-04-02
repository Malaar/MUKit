//
//  MUCommandSequence.h
//  AlarmButton
//
//  Created by Malaar on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUCommand.h"

@interface MUCommandSequence : MUCommand
{
    NSMutableArray* commands;
    __block NSInteger executionIndex;
    
    
    MUCommandCallback callback;
}

@property (nonatomic, assign) BOOL breakWhenFailure;

+ (id) commandWithCommands:(NSArray*)aCommands;
- (id) initWithCommands:(NSArray*)aCommands;
- (void) addCommand:(MUCommand*)aCommand;

- (MUCommand*) commandAtIndex:(NSInteger)anIndex;

@end
