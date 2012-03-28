//
//  MUTargetAction.h
//  MUKitMaster
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MUTargetAction : NSObject

@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL action;

+ (id) targetActionWithTarget:(id)aTarget action:(SEL)anAction;
- (id) initWithTarget:(id)aTarget action:(SEL)anAction;

- (void) setTarget:(id)aTarget action:(SEL)anAction;

- (void) sendActionFrom:(NSObject*)aSender;

@end
