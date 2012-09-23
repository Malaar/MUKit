//
//  MUCellDataTextView.m
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextView.h"
#import "MUCellTextView.h"


@implementation MUCellDataTextView

@synthesize textAlignment;
@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize keyboardType;
@synthesize keyboardAppearance;
@synthesize returnKeyType;

@synthesize validator;
@synthesize filter;

@synthesize placeholder;
@synthesize placeholderColor;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if(self)
    {
        self.cellClass = [MUCellTextView class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
        
        textAlignment = UITextAlignmentLeft;
        autocapitalizationType = UITextAutocapitalizationTypeNone;
        autocorrectionType = UITextAutocorrectionTypeNo;
        keyboardType = UIKeyboardTypeDefault;
        keyboardAppearance = UIKeyboardAppearanceDefault;
        returnKeyType = UIReturnKeyDefault;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [validator release];
    [filter release];
    
    [super dealloc];
}

//==============================================================================
- (CGFloat) cellHeightForWidth:(CGFloat)aWidth
{
    return 90;
}

@end
