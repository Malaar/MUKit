//
//  MUTableViewCell2Half.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUHalfCellView.h"
#import "MUKitDefines.h"


#define FONT_DEFAULT [UIFont systemFontOfSize:15.f]

//==============================================================================
/**
 * Класс для инициализации ячейки.
 */
@interface MUTableViewCell2HalfData : NSObject
{
    MUHalfCellPadding paddingLeftHalf;                                          ///< внутрение отступы для левой вьюшки
    MUHalfCellPadding paddingRightHalf;                                         ///< внутрение отступы для правой вьюшки
    float offsetRightView;                                                      ///< отступ для правой вьюшки (в процентах от всей ширины ячейки)
    float distanceBetweenSubView;                                               ///< расстояние между вьюшками - контентом одной половинки 
    float cellWidth;
    
    Class cellClass;                                                            ///< имя класса ячейки, который инитится этим классом

	BOOL leftHalfUserInteractionEnabled;
	BOOL rightHalfUserInteractionEnabled;
    NSUInteger tag;
    BOOL visible;
}

@property (nonatomic, readonly) Class cellClass;
// При использовании ниже приведных свойств после инициализации и создании таблицы и ячееек,
// необходимо будет выполнить reloadData всей таблицы или по конкретному индексу
@property (nonatomic, assign) float offsetRightView;
@property (nonatomic, assign) float distanceBetweenSubView;
@property (nonatomic, assign) MUHalfCellPadding paddingLeftHalf;
@property (nonatomic, assign) MUHalfCellPadding paddingRightHalf;

@property (nonatomic, assign) BOOL leftHalfUserInteractionEnabled;
@property (nonatomic, assign) BOOL rightHalfUserInteractionEnabled;
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) BOOL visible;

@property (nonatomic, assign) BOOL useAnimation;                                ///< dont touch it !!! (and do not look on it)

- (id) initWithLeftPadding:(MUHalfCellPadding) aPaddingLeftHalf 
              rightPadding:(MUHalfCellPadding) aPaddingRightHalf
           offsetRightView:(float)aOffsetRightView 
    distanceBetweenSubView:(float)aDistanceBetweenSubView;

- (float) heightCellForCellWidth:(float)aCellWidth;                                      ///< возвращает высоту ячйеки
- (float) widhtCellByOrientation;                                               ///< возвращает ширину ячейки в зависимости от ориентации девайса
- (float) maxWidhtContentForHalfType:(MUHalfCellType)aHalfType;                 ///< возвращает максимальную ширину для контена конкретной половинки ячейки с учетом отступов

- (CGSize) sizeLabelWithText:(NSString*)aText 
                        font:(UIFont*)aFont 
                    maxWidht:(float)aMaxWidth;                                  ///< определяет размер для uilable 

- (Class) getCellClass;
- (void) setupParameters;
@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface NSArray (MUTableViewCell2HalfData)

- (MUTableViewCell2HalfData*) objectByTag:(NSUInteger)aTag;

@end


//==============================================================================
//==============================================================================
//==============================================================================
/*
 * Ячейка с двумя вьюшками, для размещения в них различного контента.
 * Есть возможность гибко менять alignment контенту в HalfView (оч удобно :))
 */
@interface MUTableViewCell2Half : UITableViewCell 
{
    MUHalfCellView *leftHalfVIew;
    MUHalfCellView *rightHalfVIew;    
    MUTableViewCell2HalfData* cellData;
    float currentWidth;
    
    BOOL useAnimation;
}

@property (nonatomic, assign) BOOL leftHalfUserInteractionEnabled;
@property (nonatomic, assign) BOOL rightHalfUserInteractionEnabled;
@property (nonatomic, readonly) MUTableViewCell2HalfData* cellData;

@property (nonatomic, assign) BOOL useInReadonlyTable;                          ///< fucking magick


+ (NSString*) cellIdentifier;                                                   ///< возвращает строковый идентификатор для данного класса. Переопределить в наследника.

- (id) initWithReuseIdentifier:(NSString *) aReuseIdentifier cellData:(id)aCellData forWidth: (float) aWidth;
- (MUHalfCellAlignment) alignmentForHalfCellType:(MUHalfCellType)aHalfCellType;
- (void) setupSubviews;

// следущие методы обязательно реализовать в классах-наследниках
- (BOOL) isValidCellData:(id)aCellData;
- (void) createLeftContentView;
- (void) createRightContentView;

// Использовать только в классе MUVeraetyCellsTableControllerReadonly
- (void) updateCellData:(id)aCellData fotWidth:(float)aWidth;                   ///< использовать в cellForRowAtIndexPath
- (void) updateCellData:(id)aCellData forWidth:(float)aWidth 
          animationTime:(float)animationTime;                                   ///< использовать в cellForRowAtIndexPath

// Использовать только в классе MUVeraetyCellsTableControllerWritable
- (void) updateSizeFotWidth:(float)aWidth;                                      ///< использовать в cellForRowAtIndexPath
- (void) updateSizeFotWidth:(float)aWidth animationTime:(float)animationTime;   ///< использовать при повороте девайса

@end
//==============================================================================
