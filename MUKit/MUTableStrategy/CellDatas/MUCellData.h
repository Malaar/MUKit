//
//  MUCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUCellData : NSObject

@property (nonatomic, assign) Class controllerClass;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, readonly) NSString *cellIdentifier;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) BOOL autoDeselect;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL enebleEdit;

- (id) init;
- (CGFloat) cellHeightForWidth:(CGFloat) aWidth; 

@end
