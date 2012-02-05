//
//  MUHalfCellView.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//==============================================================================
typedef enum MUHalfCellAlignment
{
    halfCellAlignmentNone    = 1 << 0,

    // горизонтальное выравнивание
    halfCellAlignmentLeft    = 1 << 1,
    halfCellAlignmentCenter  = 1 << 2,
    halfCellAlignmentRight   = 1 << 3,

    // вертикальное выравнивание
    halfCellAlignmentTop     = 1 << 4,
    halfCellAlignmentMiddle  = 1 << 5,
    halfCellAlignmentBottom  = 1 << 6

} MUHalfCellAlignment;

//==============================================================================
typedef enum MUHalfCellType 
{
    halfCellTypeLeft    = 0,
    halfCellTypeRight   = 1
} MUHalfCellType;

//==============================================================================
typedef struct MUHalfCellPadding
{
    float leftPadding;
    float topPadding;
    float rightPadding;
    float bottomPadding;
} MUHalfCellPadding;

static inline MUHalfCellPadding MUHalfCellPaddingZero()
{
    MUHalfCellPadding padding;
    padding.leftPadding = 0;
    padding.topPadding = 0;
    padding.rightPadding = 0;
    padding.bottomPadding = 0;
    return padding;
}

static inline MUHalfCellPadding MUHalfCellPaddingMake(float aLeftPadding, float aTopPadding, float aRightPadding, float aBottomPadding)
{
    MUHalfCellPadding padding;
    padding.leftPadding = aLeftPadding;
    padding.topPadding = aTopPadding;
    padding.rightPadding = aRightPadding;
    padding.bottomPadding = aBottomPadding;
    return padding;
}

//==============================================================================
@interface MUHalfCellView : UIView 
{
    MUHalfCellPadding padding;
    MUHalfCellAlignment alignment;
    float distanceBetweenSubView;
}

@property (nonatomic, assign) MUHalfCellPadding padding; 
@property (nonatomic, assign) MUHalfCellAlignment alignment;
@property (nonatomic, assign) float distanceBetweenSubView;

@end

//==============================================================================
//==============================================================================
//==============================================================================