//
//  MUBooleanCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataStandart.h"
#import "MUTargetAction.h"


@interface MUCellDataSwitch : MUCellDataStandart

@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, readonly) MUTargetAction* targetAction;

- (void) setTarget:(id)aTarget action:(SEL)anAction;
- (void) didChangeBoolValueInSwitch:(UISwitch *) aSwitch;

@end
