//
//  MUCommandRepeated.h
//  AlarmButton
//
//  Created by Malaar on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCommand.h"

//typedef void (^MURepeatedTaskCallback) (BOOL needRepeat, BOOL taskSuccess);

@interface MUCommandRepeated : MUCommand
{
    NSInteger repeatCount;                                                      ///< haw many times command will repeate in case of failure

@private
    NSInteger currentRepetitionIndex;                                             ///< current index of repeat
    MUCommandCallback callback;
}

@property (nonatomic, assign) NSInteger repeatCount;
@property (nonatomic, readonly) NSInteger currentRepetitionIndex;

//- (void) repeatTask:(MURepeatedTaskCallback)repeatedTaskCallback;               ///< in your subclasses override this method, not 'executeWithCallback'
- (void) repeatTask;               ///< in your subclasses override this method, not 'executeWithCallback'

- (void) taskCompletedNeedRepeat:(BOOL)aNeedRepeat result:(BOOL)aTaskSuccess;

@end
