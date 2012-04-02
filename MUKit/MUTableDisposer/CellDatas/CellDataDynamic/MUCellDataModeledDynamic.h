//
//  MUCellDataModeledDynamic.h
//  Pro-Otdyh
//
//  Created by Yuriy Bosov on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataModeled.h"

//==============================================================================
typedef struct _MUCellIndent
{
    float left;
    float top;
    float right;
    float botton;
} MUCellIndent;

MUCellIndent MUCellIndentMake(float left, float top, float right, float botton);

//==============================================================================
@interface MUCellDataModeledDynamic : MUCellDataModeled
{
    MUCellIndent cellIndent;
    int currentCellWidth;
    float currentCellHeight;
}

- (MUCellIndent) setupCellIndent;
- (float) recalculateCellHeight;

@end
