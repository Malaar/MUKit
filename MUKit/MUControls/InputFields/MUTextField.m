//
//  MUTextField.m
//  MUKit
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextField.h"
#import "MUValidator.h"


@implementation MUTextField

@synthesize validatableText;
@synthesize mudelegate;

#pragma mark - Init/Dealloc
//==========================================================================================
- (id)init
{
    self = [super init];
    if (self)
    {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        super.delegate = self;
    }
    return self;
}

//==========================================================================================
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        super.delegate = self;
    }
    return self;
}

#pragma mark - MUValidationProtocol
//==========================================================================================
- (void) setValidator:(MUValidator*)aValidator
{
    if(validator != aValidator)
    {
        [validator release];
        validator = [aValidator retain];
        validator.validatableObject = self;
    }
}

//==========================================================================================
- (NSString*) validatableText
{
    return self.text;
}

//==========================================================================================
- (void) setValidatableText:(NSString *)aValidatableText
{
    self.text = aValidatableText;
}

//==========================================================================================
- (MUValidator*) validator
{
    return validator;
}

//==========================================================================================
- (BOOL) validate
{
    return (validator) ? ([validator validate]) : (YES);
}

//==========================================================================================
- (void) dealloc
{
    [super dealloc];
}

#pragma mark - UITextFieldDelegate
//==========================================================================================
- (void) setDelegate:(id<UITextFieldDelegate>)delegate
{
    NSAssert(NO, @"Must use mudelegate!");
}

//==========================================================================================
- (id<UITextFieldDelegate>) delegate
{
    NSAssert(NO, @"Must use mudelegate!");
    return nil;
}

//==========================================================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL result = NO;
    
    if([mudelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        result = [mudelegate textFieldShouldBeginEditing:textField];
    
    return result;
}

//==========================================================================================
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if([mudelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [mudelegate textFieldDidBeginEditing:textField];
}

//==========================================================================================
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL result = YES;
    
    if([mudelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        result = [mudelegate textFieldShouldEndEditing:textField];
    
    return result;
}

//==========================================================================================
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([mudelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [mudelegate textFieldDidEndEditing:textField];
}

//==========================================================================================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    
    if([mudelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        result = [mudelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return result;
}

//==========================================================================================
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    BOOL result = YES;
    
    if([mudelegate respondsToSelector:@selector(textFieldShouldClear:)])
        result = [mudelegate textFieldShouldClear:textField];
    
    return result;
}

//==========================================================================================
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL result = YES;
    
    if([mudelegate respondsToSelector:@selector(textFieldShouldReturn:)])
        result = [mudelegate textFieldShouldReturn:textField];
    
    return result;
}

//==========================================================================================
//==========================================================================================
@end
