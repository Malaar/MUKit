//
//  MUEntryCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextField.h"

@implementation MUCellDataTextField

@synthesize title, titleFont, titleColor;
@synthesize textValue, textFont, textColor, textValueSecured;
@synthesize placeholder, placeholderColor;

@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize keyboardType;
@synthesize keyboardAppearance;
@synthesize returnKeyType;


//==============================================================================
- (void) dealloc
{
    [placeholder release];
    [textValue release];
    
    [super dealloc];
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    textValue = [object valueForKey:key];
}

//==============================================================================
- (void) mapToObject
{
    [object setValue:textValue forKey:key];
}

@end
