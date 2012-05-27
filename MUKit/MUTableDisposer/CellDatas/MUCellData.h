//
//  MUCellData.h
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUCell;
@class MUCellData;


@interface MUCellData : NSObject
{
    @private
    NSMutableArray *cellSelectedHandlers;
    NSMutableArray *cellDeselectedHandler;
}

@property (nonatomic, assign) Class controllerClass;// deprecated

@property (nonatomic, retain) NSString* cellNibName;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, readonly) NSString *cellIdentifier;

@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;
@property (nonatomic, assign) BOOL autoDeselect;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL enableEdit;

- (id) init;
- (CGFloat) cellHeightForWidth:(CGFloat) aWidth; 

- (void) addCellSelectedTarget:(id)aTarget action:(SEL)anAction;
- (void) addCellDeselectedTarget:(id)aTarget action:(SEL)anAction;

- (void) performSelectedHandlers;
- (void) performDeselectedHandlers;

- (MUCell*) createCell;

@end
