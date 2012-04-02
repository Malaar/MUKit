//
//  MUCommand.h
//  AlarmButton
//
//  Created by Malaar on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MUCommandCallback)(BOOL success);

@interface MUCommand : NSObject
{
    __block BOOL isExecution;
}

@property (nonatomic, assign) BOOL isExecution;

- (void) executeWithCallback:(MUCommandCallback)aCallback;

@end
