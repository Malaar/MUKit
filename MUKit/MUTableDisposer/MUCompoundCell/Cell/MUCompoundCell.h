//
//  MUCompoundCell.h
//  MUKit
//
//  Created by Malaar on 11.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUCell.h"
#import "MUCellDataModeled.h"
#import "MUBOCompoundModel.h"

@class MUTableDisposerModeled;

@interface MUCompoundCell : MUCell
{
    NSMutableArray* subCells;
    NSMutableArray* verticalSeparatorLines;
    
    // for dequeue cells
    NSMutableDictionary *reusableCells;
}

- (UIView*)verticalSeparatorLineAtIndex:(NSUInteger)index;

@end


@interface MUCompoundCellData : MUCellDataModeled

@property (nonatomic, assign) NSInteger itemSpacing;
@property (nonatomic, weak) MUTableDisposerModeled* tableDisposer;
@property (nonatomic, strong) UIColor* verticalSeparatorLinesColor;

@property (nonatomic, readonly) NSMutableArray* cellDatas;

@end