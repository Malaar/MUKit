//
//  MUCellLd1Sw1.m
//  MUKit
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb1Sw1.h"

//==============================================================================
@implementation MUCellLb1Sw1Data

//==============================================================================
@synthesize leftText1, switchValue1, leftTextFont1;

//==============================================================================
- (void) setupParameters
{
    [super setupParameters];
    leftTextFont1 = FONT_DEFAULT;
    switchValue1 = NO;
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb1Sw1 class];
}

//==============================================================================
- (float) heightCellForCellWidth:(float)aCellWidth
{
    cellWidth = aCellWidth;
    
    float height = 0;
    
    CGSize sizeLabelText = [self sizeLabelWithText:leftText1 font:leftTextFont1 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
    height = sizeLabelText.height + paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    height = MAX(height, 44.f);
    
    return height;
}

//==============================================================================
- (void) dealloc
{
    [leftText1 release];
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1Sw1

//==============================================================================
@synthesize rightSwitch1;

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLd1Sw1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb1Sw1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.font = ((MUCellLb1Sw1Data*)cellData).leftTextFont1;
        leftLabel1.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1Sw1Data*)cellData).leftText1 
                                              font:((MUCellLb1Sw1Data*)cellData).leftTextFont1 
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);

    leftLabel1.frame = frame;
    leftLabel1.text = ((MUCellLb1Sw1Data*)cellData).leftText1;
}

//==============================================================================
- (void) createRightContentView
{
    if (rightSwitch1 == nil)
    {
        rightSwitch1 = [[[UISwitch alloc] init] autorelease];
        [rightSwitch1 setOn:((MUCellLb1Sw1Data*)cellData).switchValue1];
        [rightHalfVIew addSubview:rightSwitch1];
    }
    
    rightSwitch1.frame = CGRectMake(cellData.paddingRightHalf.leftPadding,
                                   cellData.paddingRightHalf.leftPadding,
                                   94, 
                                   27);
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
