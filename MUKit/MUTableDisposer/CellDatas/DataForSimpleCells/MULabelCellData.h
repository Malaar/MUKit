//
//  MULabelCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MULabelCellData : MUCellDataMaped

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) id value;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *valueColor;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIFont *valueFont;
@property (nonatomic, assign) UITextAlignment titleTextAlignment;

- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey title:(NSString *)aTitle;

@end
