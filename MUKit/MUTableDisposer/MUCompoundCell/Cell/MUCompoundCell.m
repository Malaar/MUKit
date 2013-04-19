//
//  MUCompoundCell.m
//  MUKit
//
//  Created by Malaar on 11.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUCompoundCell.h"
#import "MUTableDisposerModeled.h"
#import "BlocksKit.h"

static NSMutableDictionary *globalReusableCells;

@implementation MUCompoundCell

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
      globalReusableCells = [NSMutableDictionary dictionary];
    });
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        verticalSeparatorLines = [NSMutableArray new];
        self.exclusiveTouch = YES;
    }
    return self;
}

- (void)setupCellData:(MUCompoundCellData*)aCellData
{
    [super setupCellData:aCellData];

    reusableCells = globalReusableCells;
    
    subCells = [NSMutableArray array];
    
    CGFloat width = self.bounds.size.width / aCellData.cellDatas.count - aCellData.itemSpacing * (aCellData.cellDatas.count + 1);
    CGFloat x = aCellData.itemSpacing;
    
    CGRect verticalSeparatorFrame = CGRectMake(x, 0, 1, self.bounds.size.height);
    MUCell* cell;
    NSUInteger index = 0;
    
    for(MUCellDataModeled* cellData in aCellData.cellDatas)
    {
        // subcells
        
        BOOL isNewCell = NO;
        cell = [self createSubCellWithCellData:cellData isNewCell:&isNewCell];
        [subCells addObject:cell];
        
        cell.frame = CGRectMake(x, aCellData.itemSpacing, width, cellData.cellHeight);
        [self.contentView addSubview:cell];
        x += width;

        if(isNewCell && aCellData.tableDisposer.delegate && [aCellData.tableDisposer.delegate respondsToSelector:@selector(tableDisposer:didCreateCell:)])
        {
            [aCellData.tableDisposer.delegate tableDisposer:aCellData.tableDisposer didCreateCell:cell];
        }

        // separators
        UIView* verticalSeparatorLine = [self verticalSeparatorLineAtIndex:index];
        if(verticalSeparatorLine)
        {
            verticalSeparatorLine.frame = verticalSeparatorFrame;
            [self.contentView addSubview:verticalSeparatorLine];
        }
        
        index++;
    }

    for(UIView* separatorLine in verticalSeparatorLines)
        [self.contentView bringSubviewToFront:separatorLine];
}

- (MUCell *)createSubCellWithCellData:(MUCellDataModeled *)cellData isNewCell:(BOOL *)isNewCell
{
    MUCell* cell = nil;
    *isNewCell = NO;
    
    NSString *identifier = cellData.cellIdentifier;
    cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        *isNewCell = YES;
        cell = [cellData createCell];
    }
    
    [cell setupCellData:cellData];
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    MUCompoundCellData* cellData = (MUCompoundCellData*)self.cellData;
    CGFloat width = self.bounds.size.width / cellData.cellDatas.count - cellData.itemSpacing * (cellData.cellDatas.count + 1);
    CGFloat x = cellData.itemSpacing;
    for(MUCell* cell in subCells)
    {
        cell.frame = CGRectMake(x, cellData.itemSpacing, width, cell.cellData.cellHeight);
        x += width;
    }
}

#pragma mark - Reusing subcells

- (MUCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    if (!identifier) return nil;
    
    NSMutableSet *reusableCellsForIdentifier = [reusableCells objectForKey:identifier];
    
    if ([reusableCellsForIdentifier count] == 0)
        return nil;
    
    MUCell *reusableCell = [reusableCellsForIdentifier anyObject];
    [reusableCellsForIdentifier removeObject:reusableCell];
    [reusableCell prepareForReuse];
    
    return reusableCell;
}

- (void)enqueueCell:(MUCell *)cell withIdentifier:(NSString *)identifier
{
    [[self reusableCellSetForIdentifier:identifier] addObject:cell];
}

- (NSMutableSet *)reusableCellSetForIdentifier:(NSString *)identifier
{
    NSMutableSet *set = [reusableCells objectForKey:identifier];
    if (!set)
    {
        set = [NSMutableSet set];
        [reusableCells setObject:set forKey:identifier];
    }
    return set;
}

#pragma mark - 

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (MUCell* cell in subCells)
    {
        [cell removeFromSuperview];
        [self enqueueCell:cell withIdentifier:cell.cellData.cellIdentifier];
    }
}

#pragma mark - Touches

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitTestedView = [super hitTest:point withEvent:event];
    if (!hitTestedView || [hitTestedView isKindOfClass:[UIControl class]])
        return hitTestedView;
        
    for (UITableViewCell* subCell in subCells)
    {
        if(subCell == hitTestedView || subCell.contentView == hitTestedView)
        {
            hitTestedView = self;
            break;
        }
    }
    
    return hitTestedView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        CGPoint location = [touch locationInView:self];
        for(MUCell* cell in subCells)
        {
            location = [self convertPoint:location toView:cell];
            if([cell pointInside:location withEvent:event])
            {
                [cell setSelected:YES animated:NO];
                [self performBlock:^(id sender)
                 {
                     [cell.cellData performSelectedHandlers];
                     
                 } afterDelay:0.05];
                
                break;
            }
        }
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    for(MUCell* cell in subCells)
    {
        location = [self convertPoint:location toView:cell];
        if([cell pointInside:location withEvent:event] && cell.selected)
        {
            [self performBlock:^(id sender)
             {
                 [cell.cellData performDeselectedHandlers];
                 
             } afterDelay:0.05];
        }
        if(cell.selected)
            [cell setSelected:NO animated:YES];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    for(MUCell* cell in subCells)
    {
        location = [self convertPoint:location toView:cell];
        if([cell pointInside:location withEvent:event])
        {
            [cell setSelected:NO animated:NO];
            break;
        }
    }
}

#pragma mark - Separator lines

- (UIView*)verticalSeparatorLineAtIndex:(NSUInteger)index
{
    MUCompoundCellData* cellData = (MUCompoundCellData*)self.cellData;

    UIView* separatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    separatorLine.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    separatorLine.backgroundColor = cellData.verticalSeparatorLinesColor;
    return separatorLine;
}


@end


@implementation MUCompoundCellData

@synthesize cellDatas;

- (id)initWithModel:(MUBOCompoundModel*)aCompoundModel
{
    self = [super initWithModel:aCompoundModel];
    if(self)
    {
        self.cellClass = [MUCompoundCell class];
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
        self.verticalSeparatorLinesColor = [UIColor grayColor];
    }
    return self;
}

- (void)setTableDisposer:(MUTableDisposerModeled *)tableDisposer
{
    _tableDisposer = tableDisposer;

    cellDatas = [NSMutableArray array];
    MUBOCompoundModel* compoundModel = (MUBOCompoundModel*)self.model;
    for(id model in compoundModel.models)
    {
        MUCellDataModeled* cellData = [(MUTableDisposerModeled*)self.tableDisposer cellDataFromModel:model];
        if(cellData)
        {
            [cellDatas addObject:cellData];
            
            if(self.tableDisposer.modeledDelegate && [self.tableDisposer.modeledDelegate respondsToSelector:@selector(tableDisposer:didCreateCellData:)])
            {
                [self.tableDisposer.modeledDelegate tableDisposer:self.tableDisposer didCreateCellData:cellData];
            }
        }
    }
}

- (CGFloat)cellHeightForWidth:(CGFloat)aWidth
{
    CGFloat newCellHeight = 0.0f;
    for(MUCellDataModeled* cellData in self.cellDatas)
    {
        newCellHeight = MAX(cellData.cellHeight, newCellHeight);
    }
    self.cellHeight = newCellHeight + 2 * self.itemSpacing;
    return self.cellHeight;
}

@end