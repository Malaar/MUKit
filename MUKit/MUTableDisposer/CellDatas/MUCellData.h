//
//  MUCellData.h
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MUCellSelectedHandler)(id response);
typedef void (^MUCellDeselectedHandler)(id response);


@interface MUCellData : NSObject
{
    @private
    NSMutableArray *cellSelectedHandler;
    NSMutableArray *cellDeselectedHandler;
}

@property (nonatomic, assign) Class controllerClass;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, readonly) NSString *cellIdentifier;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;
@property (nonatomic, assign) BOOL autoDeselect;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL enebleEdit;

- (id) init;
- (CGFloat) cellHeightForWidth:(CGFloat) aWidth; 

- (void) addCellSelectedHandler:(MUCellSelectedHandler) aHandler;
- (void) addCellDeselectedHandler:(MUCellDeselectedHandler) aHandler;

@end
