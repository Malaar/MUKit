//
//  MUCellDataTextPair.h
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataTextPair : MUCellDataMaped

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) UIFont *titleFont;

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) UIFont *textFont;

@end
