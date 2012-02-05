//
//  MUCellLbTextView.m
//  MUKit
//
//  Created by Malaar on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCellLbTextView.h"

@implementation MUCellLbTextViewData

@synthesize leftText1;
@synthesize textViewText;

@synthesize leftTextFont1;
@synthesize textViewTextFont;

//==============================================================================
- (void) setupParameters
{
    leftTextFont1 = FONT_DEFAULT;
    textViewTextFont = FONT_DEFAULT;
}

//==============================================================================
- (Class) getCellClass
{
    return [MUCellLbTextView class];
}

//==============================================================================
- (float) heightCellForCellWidth:(float)aCellWidth
{
    cellWidth = aCellWidth;
//    float height = 0;
    float leftHeight = 0;
//    float rightHeight = 0;
    
    CGSize textSize;
    
    if (leftText1)
    {
        textSize = [self sizeLabelWithText: leftText1 font:leftTextFont1 maxWidht:[self maxWidhtContentForHalfType:halfCellTypeLeft]];
        leftHeight = textSize.height;
    }
    leftHeight += distanceBetweenSubView;
    
//    leftHeight += textViewHeight + paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    textSize = CGSizeMake(0, 0);
    if (textViewText)
    {
        textSize = [self sizeLabelWithText:textViewText font:textViewTextFont maxWidht:[self widhtCellByOrientation] - paddingLeftHalf.leftPadding - paddingRightHalf.rightPadding];
    }
//    if(textSize.height == 0)
//        textSize.height = textViewTextFont.lineHeight;
    leftHeight += textSize.height + 20;// маленький подпорочка

    leftHeight += paddingLeftHalf.topPadding + paddingLeftHalf.bottomPadding;
    
//    height = MAX(leftHeight, rightHeight);
//    height = MAX(height, 44);
    
    return leftHeight;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end


@implementation MUCellLbTextView

@synthesize textView;

//==============================================================================
- (BOOL) isValidCellData:(id)aCellData
{
    return [aCellData isKindOfClass:[MUCellLbTextViewData class]];
}

//==============================================================================
- (void) createLeftContentView
{
    if (leftLabel1 == nil)
    {
        leftLabel1 = [[[UILabel alloc] init] autorelease];
        leftLabel1.numberOfLines = 0;
        leftLabel1.font = ((MUCellLbTextViewData*)cellData).leftTextFont1;
        NSAssert(leftLabel1.font, @"Font is nil !!!");
        leftLabel1.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:leftLabel1];
    }
    
    CGSize labelSize = [cellData sizeLabelWithText:((MUCellLbTextViewData*)cellData).leftText1 
                                              font:((MUCellLbTextViewData*)cellData).leftTextFont1
                                          maxWidht:[cellData maxWidhtContentForHalfType:halfCellTypeLeft]];
    CGRect frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding,
                              labelSize.width,
                              labelSize.height);
    
    leftLabel1.frame = frame;
    leftLabel1.text = ((MUCellLbTextViewData*)cellData).leftText1;

    if (textView == nil)
    {
        textView = [[[MUTextViewAutosize alloc] init] autorelease];
        textView.font = ((MUCellLbTextViewData*)cellData).textViewTextFont;
        NSAssert(textView.font, @"Font is nil !!!");
        textView.backgroundColor = [UIColor clearColor];
        [leftHalfVIew addSubview:textView];
    }
    
    frame = CGRectMake(cellData.paddingLeftHalf.leftPadding,
                              cellData.paddingLeftHalf.topPadding + leftLabel1.frame.size.height + cellData.distanceBetweenSubView,
                              [cellData widhtCellByOrientation] - cellData.paddingLeftHalf.leftPadding - cellData.paddingRightHalf.rightPadding,
                              20);
    textView.frame = frame;
    textView.text = ((MUCellLbTextViewData*)cellData).textViewText;
}

//==============================================================================
- (void) createRightContentView
{
}

@end
