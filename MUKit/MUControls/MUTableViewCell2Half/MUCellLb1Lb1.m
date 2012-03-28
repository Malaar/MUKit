//
//  MUCellLb1Lb1.m
//  MUKit
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb1Lb1.h"

//==============================================================================
@implementation MUCellLb1Lb1Data

//==============================================================================
@synthesize leftText1, rightText1, leftTextFont1, rightTextFont1;

//==============================================================================
- (void) setupParameters
{
    leftTextFont1 = FONT_DEFAULT;
    rightTextFont1 = FONT_DEFAULT;
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
        leftHeight = textSize.height + paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    }
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
    [leftText1 release];
    [rightText1 release];
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1Lb1

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLb1Lb1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb1Lb1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.font = ((MUCellLb1Lb1Data*)cellData).leftTextFont1;
        NSAssert(leftLabel1.font, @"Font is nil !!!");
        leftLabel1.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1Lb1Data*)cellData).leftText1 
                                              font:((MUCellLb1Lb1Data*)cellData).leftTextFont1
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel1.frame = frame;
    leftLabel1.text = ((MUCellLb1Lb1Data*)cellData).leftText1;
}

//==============================================================================
- (void) createRightContentView
{
    if (rightLabel1 == nil)
    {
        rightLabel1 = [[[UILabel alloc] init] autorelease];
        rightLabel1.numberOfLines = 0;
        rightLabel1.font = ((MUCellLb1Lb1Data*)cellData).rightTextFont1;
        NSAssert(rightLabel1.font, @"Font is nil !!!");
        rightLabel1.backgroundColor = [UIColor clearColor];
        [rightHalfVIew addSubview:rightLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1Lb1Data*)cellData).rightText1 
                                              font:((MUCellLb1Lb1Data*)cellData).rightTextFont1
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeRight]];
    CGRect frame = CGRectMake(cellData.paddingRightHalf.leftPadding,
                              cellData.paddingRightHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    rightLabel1.frame = frame;
    rightLabel1.text = ((MUCellLb1Lb1Data*)cellData).rightText1;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
