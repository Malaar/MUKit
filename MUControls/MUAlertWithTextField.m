//
//  MUAlertWithTextField.m
//  MUKit
//
//  Created by Yuriy Bosov on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUAlertWithTextField.h"


@implementation MUAlertWithTextField

//==============================================================================
@synthesize textField = tfUserNameOrEmail;

//==============================================================================
- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles
{
    self = [super initWithTitle:title message:@"\n" delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) 
    {
        tfUserNameOrEmail = [[UITextField alloc] initWithFrame:CGRectMake(15.0f, 45.0f, 255.0f, 28.0f)];
        tfUserNameOrEmail.borderStyle = UITextBorderStyleRoundedRect;
		tfUserNameOrEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		tfUserNameOrEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
        tfUserNameOrEmail.autocorrectionType = UITextAutocorrectionTypeNo;
        tfUserNameOrEmail.returnKeyType = UIReturnKeySend;
		tfUserNameOrEmail.placeholder = @"Nickname or Email";
        tfUserNameOrEmail.delegate = self;
        [self addSubview:tfUserNameOrEmail];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [tfUserNameOrEmail release];
    [super dealloc];
}

#pragma mark - UITextFieldDelegate
//==============================================================================
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([tfUserNameOrEmail.text length])
    {   
        [self.delegate alertView:self clickedButtonAtIndex:1];
        [self dismissWithClickedButtonIndex:1 animated:YES];
    }
    return YES;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
