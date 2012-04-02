//
//  MUEntryCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellTextField.h"
#import "MUCellDataTextField.h"

@implementation MUCellTextField

//==============================================================================
@synthesize textField;

//==============================================================================
- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    
    float cellHeight = [aCellData cellHeightForWidth:self.frame.size.width];
    
    MUCellDataTextField *cellDataTextField = (MUCellDataTextField*)aCellData;
    
    textField = [[[MUTextField alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, cellHeight)] autorelease];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.autocapitalizationType = cellDataTextField.autocapitalizationType;
    textField.autocorrectionType = cellDataTextField.autocorrectionType;
    textField.keyboardType = cellDataTextField.keyboardType;
    textField.keyboardAppearance = cellDataTextField.keyboardAppearance;
    textField.returnKeyType = cellDataTextField.returnKeyType;
    
    textField.font = cellDataTextField.textFont;
    textField.text = cellDataTextField.text;
    textField.textColor = cellDataTextField.textColor;
    
    if (cellDataTextField.title)
    {
        CGSize titleLabelSize = [cellDataTextField.text sizeWithFont:cellDataTextField.textFont];
        UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleLabelSize.width, titleLabelSize.height)] autorelease];
        titleLabel.text = cellDataTextField.title;
        titleLabel.textColor = cellDataTextField.titleColor;
        titleLabel.font = cellDataTextField.titleFont;
        
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = titleLabel;
    }
    else
    {
        textField.leftView = nil;
    }
    
    [self.contentView addSubview:textField];
}

@end
