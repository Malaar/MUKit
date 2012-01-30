//
//  MUTextField.m
//  ROM
//
//  Created by Malaar on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextFieldPadding.h"


@implementation MUTextFieldPadding

#pragma mark - init/dealloc
//==========================================================================================
+ (id) textFieldPaddingWithBG:(UIImage*)aBG padding:(int)aPadding;
{
    return [[[MUTextFieldPadding alloc] initWithBG:aBG padding:aPadding] autorelease];
}

//==========================================================================================
- (id) initWithBG:(UIImage*)aBG padding:(int)aPadding
{
    self = [super initWithFrame: CGRectMake(0, 0, aBG.size.width, aBG.size.width)];
    if(self)
    {
        self.background = [aBG stretchableImageWithLeftCapWidth:aBG.size.width/2 topCapHeight:aBG.size.height/2];
        self.borderStyle = UITextBorderStyleNone;
        [self setPadding:aPadding];
    }
    
    return self;
}

#pragma mark - customization
//==========================================================================================
- (void) setPadding:(int)aPadding
{
    UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, aPadding, self.bounds.size.height)] autorelease];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}


//==========================================================================================
//==========================================================================================
//==========================================================================================
@end
