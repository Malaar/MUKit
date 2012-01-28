//
//  MUCellLb1Tf1.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLb1Tf1.h"

#define heidht_text_field 31.f

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1Tf1Data

//==============================================================================
@synthesize leftText1, textFieldText1, placeholderTextFieldText1, leftTextFont1, textFieldFont1;
@synthesize rightTextFieldTag;

//==============================================================================
- (void) setupParameters
{
    leftTextFont1 = FONT_DEFAULT;
    textFieldFont1 = FONT_DEFAULT;
}

//==============================================================================
- (float) heightCell
{
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
    [textFieldText1 release];
    [super dealloc];
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLb1Tf1 class];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation MUCellLb1Tf1

//==============================================================================
@synthesize textField1;

//==============================================================================
+ (NSString*) cellIdentifier
{
    return @"MUCellLb1Tf1";
}

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLb1Tf1Data class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.backgroundColor = [UIColor clearColor];
        leftLabel1.font = [((MUCellLb1Tf1Data*)cellData) leftTextFont1];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [((MUCellLb1Tf1Data*)cellData) sizeLabelWithText:((MUCellLb1Tf1Data*)cellData).leftText1 
                                                                   font:((MUCellLb1Tf1Data*)cellData).leftTextFont1 
                                                               maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel1.frame = frame;
    leftLabel1.text = [((MUCellLb1Tf1Data*)cellData) leftText1];
}

//==============================================================================
- (void) createRightContentView
{
    if (textField1 == nil)
    {
        textField1 = [[[MUTextField alloc] init] autorelease];
        textField1.backgroundColor = [UIColor clearColor];
        textField1.autoresizingMask = UIViewAutoresizingNone;
        textField1.font = ((MUCellLb1Tf1Data*)cellData).textFieldFont1;
        textField1.textColor = [UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1.0];
        [rightHalfVIew addSubview:textField1];
        textField1.text = ((MUCellLb1Tf1Data*)cellData).textFieldText1;
        textField1.placeholder = ((MUCellLb1Tf1Data*)cellData).placeholderTextFieldText1;
        
        textField1.tag = ((MUCellLb1Tf1Data*)cellData).rightTextFieldTag;
    }
    textField1.frame = CGRectMake(cellData.paddingRightHalf.leftPadding,
                                  cellData.paddingRightHalf.topPadding,
                                  rightHalfVIew.frame.size.width - cellData.paddingRightHalf.leftPadding - cellData.paddingRightHalf.rightPadding,
                                  heidht_text_field);
}

//==============================================================================
- (void)dealloc
{
    [super dealloc];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
