//
//  MUCellLb1Lb1.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb1Img1.h"

//==============================================================================
@implementation MUCellLb1Img1Data

//==============================================================================
@synthesize leftText1, rightImage1, leftTextFont1;

//==============================================================================
- (void) setupParameters
{
    leftTextFont1 = FONT_DEFAULT;
}

//==============================================================================
- (float) heightCell
{    
    float height = 0.0f;
    float leftHeight = 0.0f;
    float rightHeight = 0.0f;

    CGSize textSize;
    
    if (leftText1)
    {
        textSize = [self sizeLabelWithText: leftText1 font:leftTextFont1 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
        leftHeight = textSize.height + paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    }
    if (rightImage1)
    {
        rightHeight = rightImage1.size.height + paddingRightHalf.topPadding + paddingRightHalf.bottomPadding;
    }
    
    height = MAX(leftHeight, rightHeight);
    height = MAX(height, 44.0f);
    
    return height;
}

//==============================================================================
- (void) dealloc
{
    [leftText1 release];
    [rightImage1 release];

    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1Img1

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLb1Img1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb1Img1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.font = ((MUCellLb1Img1Data*)cellData).leftTextFont1;
        NSAssert(leftLabel1.font, @"Font is nil !!!");
        leftLabel1.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1Img1Data*)cellData).leftText1 
                                              font:((MUCellLb1Img1Data*)cellData).leftTextFont1
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel1.frame = frame;
    leftLabel1.text = ((MUCellLb1Img1Data*)cellData).leftText1;
}

//==============================================================================
- (void) createRightContentView
{
    if (rightImageView1 == nil)
    {
        rightImageView1 = [[[UIImageView alloc] initWithImage:((MUCellLb1Img1Data*)cellData).rightImage1] autorelease];
        [rightHalfVIew addSubview:rightImageView1];
    }
    
//    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1Lb1Data*)cellData).rightText1 
//                                              font:((MUCellLb1Lb1Data*)cellData).rightTextFont1
//                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeRight]];
//    CGRect frame = CGRectMake(cellData.paddingRightHalf.leftPadding,
//                              cellData.paddingRightHalf.topPadding,
//                              labelSize.width,
//                              labelSize.height);
//    rightLabel1.frame = frame;
//    rightLabel1.text = ((MUCellLb1Lb1Data*)cellData).rightText1;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
