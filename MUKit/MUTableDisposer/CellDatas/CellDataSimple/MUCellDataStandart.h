//
//  MULabelCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataStandart : MUCellDataMaped

@property (nonatomic, retain) UIImage* image;                                   ///< Use to setup image

@property (nonatomic, retain) NSURL* imageURL;                                  ///< Use to setup image asynchronous from URL
@property (nonatomic, retain) UIImage* imagePlaceholder;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) UIFont *titleFont;
@property (nonatomic, assign) UITextAlignment titleTextAlignment;

@property (nonatomic, retain) NSString* subtitle;
@property (nonatomic, retain) UIColor *subtitleColor;
@property (nonatomic, assign) UIFont *subtitleFont;

- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey;

@end
