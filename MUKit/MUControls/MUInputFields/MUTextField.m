//
//  MUTextField.m
//  MUKit
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextField.h"
#import "MUValidator.h"
#import "MUKeyboardAvoidingProtocol.h"


//==========================================================================================
//==========================================================================================
//==========================================================================================
@interface MUTextField_Holder : NSObject <UITextFieldDelegate>

@property (nonatomic, assign) MUTextField* holded;

@end

//==========================================================================================
//==========================================================================================
//==========================================================================================
@interface MUTextField ()

- (void) setup;

@end

//==========================================================================================
@implementation MUTextField

@synthesize validatableText;
@synthesize mudelegate;
@synthesize keyboardAvoiding;
@synthesize filter;

#pragma mark - Init/Dealloc
//==========================================================================================
- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

//==========================================================================================
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
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
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    delegateHolder = [MUTextField_Holder new];
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

#pragma mark - UITextFieldDelegate
//==========================================================================================
- (void) setDelegate:(id<UITextFieldDelegate>)aDelegate
{
    mudelegate = aDelegate;
}

//==========================================================================================
- (id<UITextFieldDelegate>) delegate
{
    return mudelegate;
}
@end


//==========================================================================================
//==========================================================================================
//==========================================================================================
@implementation MUTextField_Holder

@synthesize holded;

//==========================================================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL result = YES;
    
    if([holded.mudelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        result = [holded.mudelegate textFieldShouldBeginEditing:textField];
    
    return result;
}

//==========================================================================================
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [holded.keyboardAvoiding adjustOffset];
    
    if([holded.mudelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [holded.mudelegate textFieldDidBeginEditing:textField];
}

//==========================================================================================
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL result = YES;
    
    if([holded.mudelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        result = [holded.mudelegate textFieldShouldEndEditing:textField];
    
    return result;
}

//==========================================================================================
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([holded.mudelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [holded.mudelegate textFieldDidEndEditing:textField];
}

//==========================================================================================
- (BOOL)textField:(MUTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    if (textField.filter)
        result = [textField.filter filterText:textField shouldChangeCharactersInRange:range replacementString:string];
    
    if([holded.mudelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        result = [holded.mudelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return result;
}

//==========================================================================================
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    BOOL result = YES;
    
    if([holded.mudelegate respondsToSelector:@selector(textFieldShouldClear:)])
        result = [holded.mudelegate textFieldShouldClear:textField];
    
    return result;
}

//==========================================================================================
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL result = YES;
    
    [holded.keyboardAvoiding responderShouldReturn:textField];
    
    if([holded.mudelegate respondsToSelector:@selector(textFieldShouldReturn:)])
        result = [holded.mudelegate textFieldShouldReturn:textField];
    
    return result;
}

@end
