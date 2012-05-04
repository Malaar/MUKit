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

@property (nonatomic, retain) NSString* onText;
@property (nonatomic, retain) NSString* offText;

- (void) setTarget:(id)aTarget action:(SEL)anAction;

@end
