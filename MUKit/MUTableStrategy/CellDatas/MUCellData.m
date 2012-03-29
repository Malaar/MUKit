//
//  MUCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"

@implementation MUCellData

//==============================================================================
@synthesize cellClass;
@dynamic cellIdentifier;
@synthesize controllerClass;
@synthesize cellSelectionStyle;
@synthesize cellStyle;
@synthesize autoDeselect;
@synthesize visible;
@synthesize enebleEdit;

//==============================================================================
-(id) init
{
    self = [super init];
    if (self)
    {
        visible = YES;
        autoDeselect = YES;
        cellSelectionStyle = UITableViewCellSelectionStyleBlue;
        cellStyle = UITableViewCellStyleDefault;
    }
    return self;
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

@end
