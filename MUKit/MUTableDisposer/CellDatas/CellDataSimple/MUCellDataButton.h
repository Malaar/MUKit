//
//  MUButtonCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"
#import "MUTargetAction.h"

@interface MUCellDataButton : MUCellData

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, assign) UITextAlignment titleAlignment;

@property (nonatomic, readonly) MUTargetAction* targetAction;

- (void) setTarget:(id)aTarget action:(SEL)anAction;

@end
