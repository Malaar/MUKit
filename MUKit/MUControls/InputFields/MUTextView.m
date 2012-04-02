//
//  MUTextView.m
//  MUKit
//
//  Created by Yuriy Bosov on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextView.h"
#import "MUKeyboardAvoidingProtocol.h"


@implementation MUTextView

@synthesize mudelegate;
@synthesize keyboardAvoiding;

//==========================================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        super.delegate = self;
    }
    return self;
}

//==========================================================================================
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if( (self = [super initWithCoder:aDecoder]) )
    {
        super.delegate = self;
    }
    return self;
}

//==========================================================================================
- (id) initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        super.delegate = self;
    }
    return self;
}

//==========================================================================================
- (void) dealloc
{
    [validator release];
    
    [super dealloc];
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

#pragma mark - UITextViewDelegate
//==========================================================================================
- (void) setDelegate:(id<UITextViewDelegate>)delegate
{
    NSAssert(NO, @"Must use mudelegate!");
}

//==========================================================================================
- (id<UITextViewDelegate>) delegate
{
    NSAssert(NO, @"Must use mudelegate!");
    return nil;
}

//==========================================================================================
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    BOOL result = NO;
    
    if([mudelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        result = [mudelegate textViewShouldBeginEditing:textView];
    
    return result;
}

//==========================================================================================
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    BOOL result = NO;
    
    if([mudelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        result = [mudelegate textViewShouldEndEditing:textView];
    
    return result;
}

//==========================================================================================
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [keyboardAvoiding adjustOffset];
    
    if([mudelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [mudelegate textViewDidBeginEditing:textView];
}

//==========================================================================================
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([mudelegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [mudelegate textViewDidEndEditing:textView];
}

//==========================================================================================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL result = NO;
    
    if([mudelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        result = [mudelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    
    return result;
}

//==========================================================================================
- (void)textViewDidChange:(UITextView *)textView
{
    if([mudelegate respondsToSelector:@selector(textViewDidChange:)])
        [mudelegate textViewDidChange:textView];
}

//==========================================================================================
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if([mudelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [mudelegate textViewDidChangeSelection:textView];
}

//==========================================================================================
//==========================================================================================
//==========================================================================================
@end
