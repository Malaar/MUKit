//
//  MULabelCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataStandart : MUCellDataMaped

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString* subtitle;

@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, assign) UITextAlignment titleTextAlignment;

@property (nonatomic, retain) UIColor *subtitleColor;
@property (nonatomic, retain) UIFont *subtitleFont;

- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey;

@end
