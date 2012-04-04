//
//  MUEntryCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellTextField.h"
#import "MUCellDataTextField.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCellTextField ()

- (void) didChangeValueInTextField:(UITextField *) aTextField;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCellTextField

//==============================================================================
@synthesize textField;

//==============================================================================
- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    
    MUCellDataTextField *cellDataTextField = (MUCellDataTextField*)aCellData;
    
    textField = [[[MUTextField alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)] autorelease];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textField.autocapitalizationType = cellDataTextField.autocapitalizationType;
    textField.autocorrectionType = cellDataTextField.autocorrectionType;
    textField.keyboardType = cellDataTextField.keyboardType;
    textField.keyboardAppearance = cellDataTextField.keyboardAppearance;
    textField.returnKeyType = cellDataTextField.returnKeyType;
    textField.secureTextEntry = cellDataTextField.textSecured;
    
    [textField addTarget:self action:@selector(didChangeValueInTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
    textField.font = cellDataTextField.textFont;
    textField.text = cellDataTextField.text;
    textField.textColor = cellDataTextField.textColor;
    textField.placeholder = cellDataTextField.placeholder;
    
    textField.validator = cellDataTextField.validator;
    
    if (cellDataTextField.title)
    {
        CGSize titleLabelSize = [cellDataTextField.title sizeWithFont:cellDataTextField.titleFont];
        UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleLabelSize.width + 10, titleLabelSize.height)] autorelease];
        titleLabel.text = cellDataTextField.title;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = cellDataTextField.titleColor;
        titleLabel.font = cellDataTextField.titleFont;
        
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = titleLabel;
        textField.textAlignment = UITextAlignmentRight;
    }
    else
    {
        textField.leftView = nil;
    }
    
    [self.contentView addSubview:textField];
}

//==============================================================================
- (NSArray *) inputTraits
{
    return [NSArray arrayWithObject:textField];
}

//==============================================================================
- (void) didChangeValueInTextField:(UITextField *) aTextField
{
    ((MUCellDataTextField*)self.cellData).text = aTextField.text;
}

@end



