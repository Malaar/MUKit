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

@synthesize title, titleFont, titleColor;
@synthesize text, textFont, textColor, textSecured;
@synthesize placeholder, placeholderColor;

@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize keyboardType;
@synthesize keyboardAppearance;
@synthesize returnKeyType;


#pragma mark - Init/Dealloc
//==============================================================================
- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if(self)
    {
        self.cellClass = [MUCellTextField class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;

        autocapitalizationType = UITextAutocapitalizationTypeSentences;
        autocorrectionType = UITextAutocorrectionTypeDefault;
        keyboardType = UIKeyboardTypeDefault;
        keyboardAppearance = UIKeyboardAppearanceDefault;
        returnKeyType = UIReturnKeyDefault;
        
        titleFont = [UIFont systemFontOfSize:16];
        titleColor = [UIColor blackColor];
        
        textFont = [UIFont systemFontOfSize:16];
        textColor = [UIColor blackColor];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [title release];
    [titleColor release];
    [text release];
    [textColor release];
    [placeholder release];
    [placeholderColor release];
    
    [super dealloc];
}

//==============================================================================
- (void) didChangeValueInTextField:(UITextField *) aTextField
{
    NSLog(@"didChangeValueInTextField %@", aTextField);
    text = aTextField.text;
}

#pragma mark - Maping
//==============================================================================
- (void) mapFromObject
{
    text = [object valueForKey:key];
}

//==============================================================================
- (void) mapToObject
{
    [object setValue:text forKey:key];
}

@end
