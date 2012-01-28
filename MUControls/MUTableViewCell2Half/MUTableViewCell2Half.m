//
//  MUTableViewCell2Half.m
//  TimeLink
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTableViewCell2Half.h"


#define default_cell_heidht 44

@interface MUTableViewCell2HalfData (Private)

- (id) initWithParameters;

@end

//==============================================================================
@implementation MUTableViewCell2HalfData

/**
 * Перед инициализацией ячейки эти классом, можно поменять падинги и отступ для
 * правой вьюшки или другие данные, если менять эти данные после инита ячейки
 * нужно вызвать у tableView метод reloadData или медот reloadRowsAtIndexPaths
 * для конкреной ячеки, для которой были изменены данные.
 */
@synthesize paddingLeftHalf, paddingRightHalf, offsetRightView, distanceBetweenSubView, cellClass;
@synthesize leftHalfUserInteractionEnabled, rightHalfUserInteractionEnabled;
@synthesize tag;
@synthesize visible;

@synthesize useAnimation;

//==============================================================================
- (id) initWithLeftPadding:(MUHalfCellPadding) aPaddingLeftHalf 
              rightPadding:(MUHalfCellPadding) aPaddingRightHalf
           offsetRightView:(float)aOffsetRightView 
    distanceBetweenSubView:(float)aDistanceBetweenSubView
{
    self = [self initWithParameters];
    if (self) 
    {
        paddingLeftHalf = aPaddingLeftHalf;
        paddingRightHalf = aPaddingRightHalf;
        offsetRightView = aOffsetRightView;
        distanceBetweenSubView = aDistanceBetweenSubView;
    }
    return self;
}

//==============================================================================
- (id) init 
{
    self = [self initWithParameters];
    if (self) 
    {
        paddingLeftHalf = MUHalfCellPaddingMake(5, 5, 5, 5);
        paddingRightHalf = MUHalfCellPaddingMake(5, 5, 5, 5);
        offsetRightView = 0.5f;
        distanceBetweenSubView = 5;
    }
    return self;
}

//==============================================================================
- (id) initWithParameters
{
    self = [super init];
    if (self) 
    {
        cellClass = [self getCellClass];
        [self setupParameters];
		leftHalfUserInteractionEnabled = YES;
		rightHalfUserInteractionEnabled = YES;
        tag = (NSUInteger)-1;
        visible = YES;
    }
    return self;
}

//==============================================================================
- (Class) getCellClass
{
    return [MUTableViewCell2Half class];
}

//==============================================================================
- (void) setupParameters
{
    //
}

//==============================================================================
/**
 * Возвращает высоту для ячейки этого класса
 * Переопределять в каждой наследнике, если нужна другая высота
 * Default height 44 px. 
 */
- (float) heightCell
{
    return default_cell_heidht;
}

//==============================================================================
/**
 * возвращает ширину ячейки в зависимости от ориентации девайса
 */
- (float) widhtCellByOrientation
{
    float width;
    
    if( UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) )
        width = (useAnimation) ? (480) : (320);
    else
        width = (useAnimation) ? (320) : (480);
    
    return width;
}

//==============================================================================
/**
 *возвращает максимальную ширину для контена конкретной половинки ячейки с учетом отступов
 */
- (float) maxWidhtContentForHalfType:(MUHalfCellType)aHalfType
{
    float maxWidht;
    
    if (aHalfType == halfCellTypeLeft)
        maxWidht = [self widhtCellByOrientation] * offsetRightView - paddingLeftHalf.leftPadding - paddingLeftHalf.rightPadding;
    else
        maxWidht = [self widhtCellByOrientation] * (1 - offsetRightView) - paddingRightHalf.leftPadding - paddingRightHalf.rightPadding;
    return maxWidht;
}

//==============================================================================
/**
 * определяет размер для uilable 
 */
- (CGSize) sizeLabelWithText:(NSString*)aText 
                        font:(UIFont*)aFont 
                    maxWidht:(float)aMaxWidth
{
    CGSize sizeLabel = CGSizeZero;
    if (aText != nil)
        sizeLabel = [aText sizeWithFont:aFont constrainedToSize:CGSizeMake(aMaxWidth, MAXFLOAT)];
    return sizeLabel;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation NSArray (MUTableViewCell2HalfData)

- (MUTableViewCell2HalfData*) objectByTag:(NSUInteger)aTag
{
    MUTableViewCell2HalfData* result = nil;
    for(MUTableViewCell2HalfData* cellData in self)
    {
        if(cellData.tag == aTag)
        {
            result = cellData;
            break;
        }
    }
    
    return result;
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUTableViewCell2Half (Private)

- (void) createContentForHalfCellType:(MUHalfCellType) aHalfCellType;
- (void) resizeHalfView;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUTableViewCell2Half

@synthesize cellData;
@dynamic leftHalfUserInteractionEnabled;
@dynamic rightHalfUserInteractionEnabled;

@synthesize useInReadonlyTable;


//==============================================================================
/**
 * возвращает строковый идентификатор для данного класса. 
 * Переопределить в наследника
 */
+ (NSString*) cellIdentifier
{
    return @"cell_type";
}

//==============================================================================
/**
 * Создание ячейки. Использовать только этот метод!!!
 * В наследниках обязательно вызывать метод базового класса.
 */
- (id) initWithReuseIdentifier:(NSString *)aReuseIdentifier cellData:(MUTableViewCell2HalfData*)aCellData forWidth:(float)aWidth
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aReuseIdentifier];
    if (self)
    {
        if ([self isValidCellData:aCellData]) 
            cellData = [aCellData retain];
        else
            cellData = nil;
        
        currentWidth = aWidth;
        
        [self setupSubviews];
    }
    return self;
}

//==============================================================================
/**
 * Метод определяет, что данные для ячейки являются правильными для данного 
 * класса. Переопределять в наследниках обязательно!!!
 * Метод базового класса всегда возвращает false, т.е. cellData ни когда не будет 
 * проиничена.
 */ 
- (BOOL) isValidCellData:(id)aCellData
{
    return NO;
}

//==============================================================================
/**
 * When create your subclass with own subviews you need to override this method and call parent method 'setupSubviews'.
 * Create subviews here.
 */
- (void) setupSubviews
{
    if (cellData == nil)
        return;
    
    float heigth = [cellData heightCell];
    CGSize cellSize = CGSizeMake(currentWidth, heigth);
    
    // left half view
    if (leftHalfVIew)
        [leftHalfVIew removeFromSuperview];
    
    leftHalfVIew = [[[MUHalfCellView alloc] initWithFrame:CGRectMake(0, 
                                                                     0, 
                                                                     cellSize.width * cellData.offsetRightView, 
                                                                     cellSize.height)] autorelease];
    leftHalfVIew.backgroundColor = [UIColor clearColor];
    leftHalfVIew.padding = cellData.paddingLeftHalf;
    [self addSubview:leftHalfVIew];
    
    // rigth half view
    if (rightHalfVIew)
        [rightHalfVIew removeFromSuperview];
    
    rightHalfVIew = [[[MUHalfCellView alloc] initWithFrame:CGRectMake(cellSize.width * cellData.offsetRightView,
                                                                      0,
                                                                      cellSize.width *(1 - cellData.offsetRightView), 
                                                                      cellSize.height)] autorelease];
    rightHalfVIew.backgroundColor = [UIColor clearColor];
    rightHalfVIew.padding = cellData.paddingRightHalf;
    [self addSubview:rightHalfVIew];
    
    [self createContentForHalfCellType:halfCellTypeLeft];
    [self createContentForHalfCellType:halfCellTypeRight];    
}

//==============================================================================
/**
 * Обновить размер(фрейм) HalfViews, т.к. не используем autoresizingMask.
 */
- (void) resizeHalfView
{
    float heigth = [cellData heightCell];
    CGSize cellSize = CGSizeMake(currentWidth, heigth);

    leftHalfVIew.frame = CGRectMake(0, 
                                    0, 
                                    cellSize.width * cellData.offsetRightView, 
                                    cellSize.height);
    rightHalfVIew.frame = CGRectMake(cellSize.width * cellData.offsetRightView,
                                     0,
                                     cellSize.width *(1 - cellData.offsetRightView), 
                                     cellSize.height);
}

//==============================================================================
- (void) updateCellData:(id)aCellData fotWidth:(float)aWidth animationTime:(float)animationTime
{
    if ([self isValidCellData:aCellData])
    {
        if (cellData)
            [cellData release];
        cellData = [aCellData retain];
        
        cellData.useAnimation = useAnimation = !useInReadonlyTable;
        
        [self updateSizeFotWidth:aWidth animationTime:animationTime];
    }
}

//==============================================================================
- (void) updateCellData:(id)aCellData fotWidth:(float)aWidth
{
    if ([self isValidCellData:aCellData])
    {
        if (cellData)
            [cellData release];
        cellData = [aCellData retain];

        [self updateSizeFotWidth:aWidth];
    }
}

//==============================================================================
- (void) updateSizeFotWidth:(float)aWidth
{
    if (!cellData)
        return;
    
    currentWidth = aWidth;
    
    [self resizeHalfView];    
    [self createContentForHalfCellType:halfCellTypeLeft];
    [self createContentForHalfCellType:halfCellTypeRight];

}

//==============================================================================
- (void) updateSizeFotWidth:(float)aWidth animationTime:(float)animationTime
{
    if (!cellData)
        return;

    cellData.useAnimation = useAnimation = !useInReadonlyTable;

    currentWidth = aWidth;
    
    [UIView animateWithDuration:animationTime
                     animations:^
                     {
                         [self resizeHalfView];
                     }
                     completion:^(BOOL finished)
                     {
                         cellData.useAnimation = NO;	
                     }];
    
    [self createContentForHalfCellType:halfCellTypeLeft];
    [self createContentForHalfCellType:halfCellTypeRight];

}

//==============================================================================
/**
 * Создание контент-представления (UIView*) для конкретной половинки ячейки. 
 */
- (void) createContentForHalfCellType:(MUHalfCellType) aHalfCellType
{
    if (cellData == nil)
        return;
    
    if (aHalfCellType == halfCellTypeLeft && leftHalfVIew)
    {
        [self createLeftContentView];
        leftHalfVIew.alignment = [self alignmentForHalfCellType:halfCellTypeLeft];
		self.leftHalfUserInteractionEnabled = cellData.leftHalfUserInteractionEnabled;
    }
    else if (aHalfCellType == halfCellTypeRight && rightHalfVIew)
    {
        [self createRightContentView];
        rightHalfVIew.alignment = [self alignmentForHalfCellType:halfCellTypeRight];
		self.rightHalfUserInteractionEnabled = cellData.rightHalfUserInteractionEnabled;
    }
}

//==============================================================================
/**
 * Создание контент-представления (UIView*) для левой половинки ячейки. 
 * Переопределять в наследнике. 
 */
- (void) createLeftContentView
{
    // empty by default
}

//==============================================================================
/**
 * Создание контент-пердставления (UIView*) для правой половинки ячейки. 
 * Переопределять в наследнике.
 */
- (void) createRightContentView
{
    // empty by default
}

//==============================================================================
- (MUHalfCellAlignment) alignmentForHalfCellType:(MUHalfCellType)aHalfCellType
{
    return halfCellAlignmentLeft | halfCellAlignmentTop;
}

//==============================================================================
- (void)dealloc
{
    [cellData release];
    [super dealloc];
}

//==============================================================================
- (BOOL) leftHalfUserInteractionEnabled
{
	return leftHalfVIew.userInteractionEnabled;
}

//==============================================================================
- (BOOL) rightHalfUserInteractionEnabled
{
	return rightHalfVIew.userInteractionEnabled;
}

//==============================================================================
- (void) setLeftHalfUserInteractionEnabled:(BOOL)intercationEnabled
{
	leftHalfVIew.userInteractionEnabled = intercationEnabled;
    for(UIView* subView in leftHalfVIew.subviews)
    {
        subView.userInteractionEnabled = intercationEnabled;
    }
}

//==============================================================================
- (void) setRightHalfUserInteractionEnabled:(BOOL)intercationEnabled
{
	rightHalfVIew.userInteractionEnabled = intercationEnabled;
    for(UIView* subView in rightHalfVIew.subviews)
    {
        subView.userInteractionEnabled = intercationEnabled;
    }
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
