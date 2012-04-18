//
//  MUTextView.m
//  MUKit
//
//  Created by Yuriy Bosov on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextView.h"
#import "MUKeyboardAvoidingProtocol.h"


//==========================================================================================
//==========================================================================================
//==========================================================================================
@interface MUTextView_Holder : NSObject <UITextViewDelegate>

@property (nonatomic, assign) MUTextView* holded;

@end

//==========================================================================================
//==========================================================================================
//==========================================================================================
@interface MUTextView ()

- (void) setup;

@end

//==========================================================================================
@implementation MUTextView

@synthesize mudelegate;
@synthesize keyboardAvoiding;
@synthesize observedText;
@synthesize inputTextFilter;

//==========================================================================================
- (id) init
{
    if( (self = [super init]) )
    {
        [self setup];
    }
    return self;
}

//==========================================================================================
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if( (self = [super initWithCoder:aDecoder]) )
    {
        [self setup];
    }
    return self;
}

//==========================================================================================
- (id) initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setup];
    }
    return self;
}

//==========================================================================================
- (void) dealloc
{
    [delegateHolder release];
    [validator release];
    [inputTextFilter release];
    
    [super dealloc];
}

//==========================================================================================
- (void) setup
{
    delegateHolder = [MUTextView_Holder new];
    delegateHolder.holded = self;
    super.delegate = delegateHolder;
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
    if(delegate)
    {
        NSAssert(NO, @"Must use mudelegate!");
    }
}

//==========================================================================================
- (id<UITextViewDelegate>) delegate
{
    return delegateHolder;
}

//==========================================================================================
//==========================================================================================
//==========================================================================================
@end


@implementation MUTextView_Holder

@synthesize holded;

//==========================================================================================
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    BOOL result = YES;
    
    if([holded.mudelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        result = [holded.mudelegate textViewShouldBeginEditing:textView];
    
    return result;
}

//==========================================================================================
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    BOOL result = YES;
    
    if([holded.mudelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        result = [holded.mudelegate textViewShouldEndEditing:textView];
    
    return result;
}

//==========================================================================================
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [holded.keyboardAvoiding adjustOffset];
    
    if([holded.mudelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [holded.mudelegate textViewDidBeginEditing:textView];
}

//==========================================================================================
- (void)textViewDidEndEditing:(UITextView *)textView
{
    holded.observedText = textView.text;
    
    if([holded.mudelegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [holded.mudelegate textViewDidEndEditing:textView];
}

//==========================================================================================
- (BOOL)textView:(MUTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL result = YES;
    
    if (textView.inputTextFilter) 
    {
        result = [textView.inputTextFilter filterText:textView shouldChangeCharactersInRange:range replacementString:text];
    }
    
    if([holded.mudelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        result = [holded.mudelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    
    return result;
}

//==========================================================================================
- (void)textViewDidChange:(UITextView *)textView
{
    if([holded.mudelegate respondsToSelector:@selector(textViewDidChange:)])
        [holded.mudelegate textViewDidChange:textView];
}

//==========================================================================================
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if([holded.mudelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [holded.mudelegate textViewDidChangeSelection:textView];
}


@end