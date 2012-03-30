//
//  MUBooleanCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULabelCellData.h"

@interface MUBooleanCellData : MULabelCellData
{
    SEL switchAction;
    id switchTarget;
}

@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, assign) SEL switchAction;
@property (nonatomic, assign) id switchTarget;

- (void) addSwitchTarget:(id)aTarget action:(SEL)aAction;

@end
