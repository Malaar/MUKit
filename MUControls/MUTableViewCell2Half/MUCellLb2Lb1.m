//
//  MUCellLb2Lb1.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb2Lb1.h"

//==============================================================================
@implementation MUCellLb2Lb1Data

//==============================================================================
@synthesize leftText2, leftTextFont2;

//==============================================================================
- (void) setupParameters
{
    [super setupParameters];
    leftTextFont2 = FONT_DEFAULT;
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb2Lb1 class];
}

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
- (void) dealloc
{
    [leftText2 release];
    
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb2Lb1

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLb2Lb1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb2Lb1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    [super createLeftContentView];

    MUCellLb2Lb1Data* aCellData = (MUCellLb2Lb1Data*)cellData;
    CGSize labelSize;
    CGRect frame;
    
    if (leftLabel2 == nil)
    {
        leftLabel2 = [[[UILabel alloc] init] autorelease];
        leftLabel2.font = aCellData.leftTextFont2;
        NSAssert(leftLabel2.font, @"Font is nil !!!");
        leftLabel2.numberOfLines = 0;
        leftLabel2.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel2];
    }
    
    labelSize = [cellData sizeLabelWithText:aCellData.leftText2
                                       font:aCellData.leftTextFont2 
                                   maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    
    frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                       leftLabel1.frame.origin.y + leftLabel1.frame.size.height + cellData.distanceBetweenSubView,
                       labelSize.width,
                       labelSize.height);
    
    leftLabel2.frame = frame;
    leftLabel2.text = aCellData.leftText2;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
