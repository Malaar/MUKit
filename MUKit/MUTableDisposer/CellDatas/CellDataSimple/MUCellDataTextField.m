//
//  MUEntryCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextField.h"
#import "MUCellTextField.h"


@implementation MUCellDataTextField

@synthesize textSecured;
@synthesize placeholder, placeholderColor;

@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize keyboardType;
@synthesize keyboardAppearance;
@synthesize returnKeyType;

@synthesize validator;
@synthesize inputFilter;

#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if(self)
    {
        self.cellClass = [MUCellTextField class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;

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
    [placeholder release];
    [placeholderColor release];
    [validator release];
    [inputFilter release];
    
    [super dealloc];
}

@end
