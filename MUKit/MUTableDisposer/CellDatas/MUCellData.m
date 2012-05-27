//
//  MUCellData.m
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"
#import "MUTargetAction.h"

@implementation MUCellData

//==============================================================================
@synthesize cellNibName;
@synthesize cellClass;
@dynamic cellIdentifier;
@synthesize controllerClass;
@synthesize cellSelectionStyle;
@synthesize cellStyle;
@synthesize cellAccessoryType;
@synthesize autoDeselect;
@synthesize visible;
@synthesize enableEdit;

//==============================================================================
-(id) init
{
    self = [super init];
    if (self)
    {
        visible = YES;
        autoDeselect = YES;
        enableEdit = YES;
        cellSelectionStyle = UITableViewCellSelectionStyleBlue;
        cellStyle = UITableViewCellStyleDefault;
        cellAccessoryType = UITableViewCellAccessoryNone;
        
        cellSelectedHandlers = [NSMutableArray new];
        cellDeselectedHandler = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [cellNibName release];
    [cellSelectedHandlers release];
    [cellDeselectedHandler release];
    
    [super dealloc];
}

//==============================================================================
- (CGFloat) cellHeightForWidth:(CGFloat) aWidth
{
    return 44.f;
}

//==============================================================================
- (NSString *) cellIdentifier
{
    return NSStringFromClass(self.cellClass);
}

//==============================================================================
- (void) addCellSelectedTarget:(id)aTarget action:(SEL)anAction
{
    [cellSelectedHandlers addObject:[MUTargetAction targetActionWithTarget:aTarget action:anAction]];
}

//==============================================================================
- (void) addCellDeselectedTarget:(id)aTarget action:(SEL)anAction
{
    [cellDeselectedHandler addObject:[MUTargetAction targetActionWithTarget:aTarget action:anAction]];
}

//==============================================================================
- (void) performSelectedHandlers
{
    for(MUTargetAction* handler in cellSelectedHandlers)
    {
        [handler sendActionFrom:self];
    }
}

//==============================================================================
- (void) performDeselectedHandlers
{
    for(MUTargetAction* handler in cellDeselectedHandler)
    {
        [handler sendActionFrom:self];
    }
}

//==============================================================================
- (MUCell*) createCell
{
    MUCell* cell = nil;
    
    if(cellNibName)
        cell = (MUCell*)[[[NSBundle mainBundle] loadNibNamed:cellNibName owner:self options:nil] lastObject];
    else
        cell = [[[self.cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:self.cellIdentifier] autorelease];
    
    return cell;
}

@end
