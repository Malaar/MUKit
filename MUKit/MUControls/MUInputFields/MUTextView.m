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

@property (nonatomic, retain) UITextView* lbPlaceholder;

- (void) setup;
- (void) setHiddenPlaceHolder:(BOOL)hidden;

@end

//==========================================================================================
@implementation MUTextView

@synthesize mudelegate;
@synthesize keyboardAvoiding;
@synthesize observedText;
@synthesize filter;

@synthesize placeholder;
@synthesize placeholderColor;

@synthesize lbPlaceholder = _lbPlaceholder;

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
    super.delegate = nil;
    [delegateHolder release];
    [validator release];
    [filter release];
    
    [placeholder release];
    [placeholderColor release];
    
    [super dealloc];
}

//==========================================================================================
- (void) setup
{
    delegateHolder = [MUTextView_Holder new];
    delegateHolder.holded = self;
    
    placeholderColor = [[UIColor grayColor] retain];
    
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

#pragma mark - Placeholder
//==========================================================================================
- (UITextView*)lbPlaceholder
{
    if (!_lbPlaceholder)
    {
        _lbPlaceholder = [[[UITextView alloc] initWithFrame:self.bounds] autorelease];
        _lbPlaceholder.backgroundColor = [UIColor clearColor];
        _lbPlaceholder.text = placeholder;
        _lbPlaceholder.textColor = placeholderColor;
        _lbPlaceholder.font = self.font;
        _lbPlaceholder.userInteractionEnabled = NO;
        _lbPlaceholder.hidden = [self.text length] > 0;
        _lbPlaceholder.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_lbPlaceholder];
    }
    return _lbPlaceholder;
}

//==========================================================================================
- (void)setPlaceholder:(NSString *)aPlaceholder
{
    [placeholder release];
    placeholder = [aPlaceholder retain];
    self.lbPlaceholder.text = placeholder;
}

//==========================================================================================
- (void)setPlaceholderColor:(UIColor *)aPlaceholderColor
{
    [placeholderColor release];
    placeholderColor = [aPlaceholderColor retain];
    self.lbPlaceholder.textColor =  placeholderColor;
}

//==========================================================================================
- (void)setText:(NSString *)text
{
    [super setText:text];
    if (placeholder)
        self.lbPlaceholder.hidden = [self.text length] > 0;
}

//==========================================================================================
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    if (placeholder)
        self.lbPlaceholder.font = font;
}

//==========================================================================================
- (void)setHiddenPlaceHolder:(BOOL)hidden
{
    self.lbPlaceholder.hidden = hidden;
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
    
    if (textView.filter) 
    {
        result = [textView.filter filterText:textView shouldChangeCharactersInRange:range replacementString:text];
    }
    
    if([holded.mudelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        result = [holded.mudelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    
    if (([textView.text length] == 1 && [text length] == 0) ||
        ([textView.text length] == range.length && range.length != 0))
    {
        [textView setHiddenPlaceHolder:NO];
    }
    else
    {
        [textView setHiddenPlaceHolder:[textView.text length] > 0 || [text length] > 0];
    }
    
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