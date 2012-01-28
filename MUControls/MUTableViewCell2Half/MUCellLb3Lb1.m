//
//  MUCellLb3Lb1.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb3Lb1.h"

//==============================================================================
@implementation MUCellLb3Lb1Data

//==============================================================================
@synthesize leftText3, leftTextFont3;

//==============================================================================
- (float) heightCell
{
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
        textSize = [self sizeLabelWithText: leftText2 font:leftTextFont2 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
        leftHeight += distanceBetweenSubView + textSize.height;
    }
    if (leftText3) 
    {
        textSize = [self sizeLabelWithText: leftText3 font:leftTextFont3 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
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
- (void) setupParameters
{
    [super setupParameters];
    leftTextFont3 = FONT_DEFAULT;
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb3Lb1 class];
}

//==============================================================================
- (void) dealloc
{
    [leftText3 release];
    
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb3Lb1

//==============================================================================
- (void) createLeftContentView
{
    [super createLeftContentView];
    
    MUCellLb3Lb1Data* aCellData = (MUCellLb3Lb1Data*)cellData;
    
    if (leftLabel3 == nil)
    {
        leftLabel3 = [[[UILabel alloc] init] autorelease];
        leftLabel3.font = aCellData.leftTextFont3;
        leftLabel3.numberOfLines = 0;
        leftLabel3.backgroundColor = [UIColor clearColor];
        leftLabel3.textColor = [UIColor grayColor];
        [leftHalfVIew addSubview:leftLabel3];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:aCellData.leftText3
                                       font:aCellData.leftTextFont3
                                   maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                       leftLabel2.frame.origin.y + leftLabel2.frame.size.height + cellData.distanceBetweenSubView,
                       labelSize.width,
                       labelSize.height);
    
    leftLabel3.frame = frame;
    leftLabel3.text = aCellData.leftText3;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
