//
//  MUCellLb2WithFullWidthLb1.m
//  MUKit
//
//  Created by Yuriy Bosov on 9/12/11.
//  Copyright 2011 DIMALEX LLC. All rights reserved.
//

#import "MUCellLb2WithFullWidthLb1.h"

@implementation MUCellLb2WithFullWidthLb1Data

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb2WithFullWidthLb1 class];
}

//==============================================================================
- (float) heightCellForCellWidth:(float)aCellWidth
{
    cellWidth = aCellWidth;
    
    float height = 0;
    float leftHeight = 0;
    float rightHeight = 0;
    
    CGSize textSize;
    
    if (leftText1)
    {
        textSize = [self sizeLabelWithText: leftText1 font:leftTextFont1 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
        leftHeight = textSize.height;
    }
    if (leftText2) 
    {
        textSize = [self sizeLabelWithText: leftText2 font:leftTextFont2 maxWidht:cellWidth - paddingLeftHalf.leftPadding - paddingRightHalf.rightPadding];
        leftHeight += distanceBetweenSubView + textSize.height;
    }
    leftHeight += paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    
    if (rightText1)
    {
        textSize = [self sizeLabelWithText:rightText1 font:rightTextFont1 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeRight]];
        rightHeight = textSize.height + paddingRightHalf.topPadding + paddingRightHalf.bottomPadding;
    }
    
    height = MAX(leftHeight, rightHeight);
    height = MAX(height, 44);
    
    return height;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCellLb2WithFullWidthLb1

//==============================================================================

- (void) createLeftContentView
{
    [super createLeftContentView];
    
    MUCellLb2WithFullWidthLb1Data* aCellData = (MUCellLb2WithFullWidthLb1Data*)cellData;
    
    CGSize labelSize = [cellData sizeLabelWithText:aCellData.leftText2
                                              font:aCellData.leftTextFont2
                                          maxWidht:[cellData widhtCellByOrientation] - cellData.paddingLeftHalf.leftPadding - cellData.paddingRightHalf.rightPadding];
    
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              leftLabel1.frame.origin.y + leftLabel1.frame.size.height + cellData.distanceBetweenSubView,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel2.frame = frame;    
}

//==============================================================================
- (MUHalfCellAlignment) alignmentForHalfCellType:(MUHalfCellType)aHalfCellType 
{
    MUHalfCellAlignment alignment = halfCellAlignmentNone;
    if (aHalfCellType == halfCellTypeLeft) 
        alignment = halfCellAlignmentLeft | halfCellAlignmentMiddle;
    else if (aHalfCellType == halfCellTypeRight)
        alignment = halfCellAlignmentRight | halfCellAlignmentTop;
    return alignment;
    
}

//==============================================================================
//==============================================================================
//==============================================================================
@end

