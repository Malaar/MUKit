//
//  MUTargetAction.h
//  MUKitMaster
//
//  Created by Malaar on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//==============================================================================
@interface MUTargetAction : NSObject

@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL action;

+ (id) targetActionWithTarget:(id)aTarget action:(SEL)anAction;
- (id) initWithTarget:(id)aTarget action:(SEL)anAction;

- (void) setTarget:(id)aTarget action:(SEL)anAction;
- (void) sendActionFrom:(NSObject*)aSender;

@end


//==============================================================================
@interface MUTargetActionList : NSObject
{
    NSMutableArray* taList;
}

- (void) addTarget:(id)aTarget action:(SEL)anAction;
- (void) sendActionsFrom:(NSObject*)aSender;

@end


//==============================================================================
@protocol MUTargetActionListProtocol <NSObject>

@property (nonatomic, readonly) MUTargetActionList* taList;

- (void) addTarget:(id)aTarget action:(SEL)anAction;

@end