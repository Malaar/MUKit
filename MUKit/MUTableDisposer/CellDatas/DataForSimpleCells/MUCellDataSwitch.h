//
//  MUBooleanCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataStandart.h"

@class MUTargetAction;

@interface MUCellDataSwitch : MUCellDataStandart
{
    MUTargetAction* targetAction;
}

@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, readonly) SEL switchAction;
@property (nonatomic, readonly) id switchTarget;

- (void) setSwitchTarget:(id)aTarget action:(SEL)anAction;

@end
