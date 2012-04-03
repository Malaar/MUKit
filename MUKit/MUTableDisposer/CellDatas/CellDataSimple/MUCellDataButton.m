//
//  MUButtonCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataButton.h"
#import "MUCellButton.h"


@implementation MUCellDataButton

@synthesize targetAction;

@synthesize title;
@synthesize titleFont;
@synthesize titleColor;
@synthesize titleAlignment;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) init
{
    self = [super init];
    if(self)
    {
        self.cellClass = [MUCellButton class];
        
        titleAlignment = UITextAlignmentLeft;
        titleFont = [UIFont systemFontOfSize:18];
        titleColor = [UIColor blackColor];
        targetAction = [[MUTargetAction alloc] init];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [title release];
    [titleColor release];
    [targetAction release];
    
    [super dealloc];
}

#pragma mark - Target/Action
//==============================================================================
- (void) setTarget:(id)aTarget action:(SEL)anAction
{
    [targetAction setTarget:aTarget action:anAction];
    [self addCellSelectedTarget:targetAction.target action:targetAction.action];
}

@end
