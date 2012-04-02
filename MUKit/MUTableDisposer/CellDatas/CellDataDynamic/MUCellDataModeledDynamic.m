//
//  MUCellDataModeledDynamic.m
//  Pro-Otdyh
//
//  Created by Yuriy Bosov on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataModeledDynamic.h"

//==============================================================================
MUCellIndent MUCellIndentMake(float left, float top, float right, float botton)
{
    MUCellIndent cellIndent;
    cellIndent.left = left;
    cellIndent.top = top;
    cellIndent.right = right;
    cellIndent.botton = botton;
    return cellIndent;
}

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellDataModeledDynamic

//==============================================================================
- (id) initWithModel:(id)aModel
{
    self = [super initWithModel:aModel];
    if (self)
    {
        cellIndent = [self setupCellIndent];
    }
    return self;
}

//==============================================================================
- (MUCellIndent) setupCellIndent
{
    return MUCellIndentMake(5, 5, 20, 5);
}

//==============================================================================
- (float) cellHeightForWidth:(CGFloat)aWidth
{
    if ((int)aWidth != currentCellWidth)
    {
        currentCellWidth = (int)aWidth;
        currentCellHeight = [self recalculateCellHeight];
    }
    return currentCellHeight;
}

//==============================================================================
- (float) recalculateCellHeight
{
    return 44.f;
}

@end
