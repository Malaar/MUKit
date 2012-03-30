//
//  MUBooleanCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUBooleanCellData.h"

@implementation MUBooleanCellData

@synthesize boolValue;
@synthesize switchAction;
@synthesize switchTarget;

#pragma mark - Init/Dealloc
//==============================================================================
- (void) addSwitchTarget:(id)aTarget action:(SEL)aAction
{
    self.switchTarget = aTarget;
    self.switchAction = aAction;
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    boolValue = [[object valueForKey:key] boolValue];
}

//==============================================================================
- (void) mapToObject
{
    [object setValue:[NSNumber numberWithBool:boolValue] forKey:key];
}

@end
