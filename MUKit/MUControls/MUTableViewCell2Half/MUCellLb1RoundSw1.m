//
//  MUCellLb1RoundSw1.m
//  MUKit
//
//  Created by Malaar on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb1RoundSw1.h"


//==============================================================================
@implementation MUCellLb1RoundSw1Data

//==============================================================================
@synthesize leftText1, leftTextFont1, switchValue1;
@synthesize switchOnText, switchOffText, switchOnTintColor;

//==============================================================================
- (void) setupParameters
{
    [super setupParameters];
    leftTextFont1 = FONT_DEFAULT;
    switchValue1 = NO;
    switchOnText = @"ON";
    switchOffText = @"OFF";
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb1RoundSw1 class];
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
    [switchOnText release];
    [switchOffText release];
    [switchOnTintColor release];
    
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1RoundSw1

//==============================================================================
@synthesize rightSwitch1;

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLd1RoundSw1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb1RoundSw1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.font = ((MUCellLb1RoundSw1Data*)cellData).leftTextFont1;
        leftLabel1.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLb1RoundSw1Data*)cellData).leftText1 
                                              font:((MUCellLb1RoundSw1Data*)cellData).leftTextFont1 
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel1.frame = frame;
    leftLabel1.text = ((MUCellLb1RoundSw1Data*)cellData).leftText1;
}

//==============================================================================
- (void) createRightContentView
{
    if (rightSwitch1 == nil)
    {
        rightSwitch1 = [[[DCRoundSwitch alloc] init] autorelease];
        [rightSwitch1 setOn:((MUCellLb1RoundSw1Data*)cellData).switchValue1];
        rightSwitch1.onText = ((MUCellLb1RoundSw1Data*)cellData).switchOnText;
        rightSwitch1.offText = ((MUCellLb1RoundSw1Data*)cellData).switchOffText;
        rightSwitch1.onTintColor = ((MUCellLb1RoundSw1Data*)cellData).switchOnTintColor;
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
