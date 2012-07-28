//
//  MUInputTextFilter.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUFilter.h"

//==============================================================================
//==============================================================================
//==============================================================================
/// text filter : base class
@implementation MUFilter

@synthesize maxLengthText;

//==============================================================================
- (id) init
{
    if( (self = [self initWithMaxLengthText:NSNotFound]) )
    {
    }
    return self;
}

//==============================================================================
- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText
{
    if( (self = [super init]) )
    {
        maxLengthText = aMaxLengthText;
    }
    return self;
}

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    if ([string length] > 0 &&  maxLengthText > 0)
    {
        result = [[inputTextField text] length] < maxLengthText;
    }
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only number
@implementation MUFilterNumbers

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    
    if ([string length] > 0)
    {
        result = [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound;
        result &= [[inputTextField text] length] < maxLengthText;
    }
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only letters
@implementation MUFilterLetters

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    
    if ([string length] > 0)
    {
        result = [string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound;
        result &= [[inputTextField text] length] < maxLengthText;
    }
    
    return result;
}


@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUFilterLettersAndDigits

- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    
    if([string length] > 0)
    {
        NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^[0-9a-zA-Z]+$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger count = [regExp numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
        result = count == 1;
        result &= [[inputTextField text] length] < maxLengthText;
        [regExp release];
    }
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUFilterNumbersWithEditableRange

@synthesize editableRange;

//==============================================================================
- (id) init
{
    if( (self = [self initWithEditableRange:NSMakeRange(0, 0)]) )
    {
    }
    return self;
}

//==============================================================================
- (id)initWithEditableRange:(NSRange)anEditableRange
{
    self = [super init];
    if (self)
    {
        editableRange = anEditableRange;
    }
    return self;
}

//==============================================================================
- (BOOL)filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    
    if (editableRange.length > 0)
    {
        if ([string length] > 0) 
        {
            result = [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound;            
            result &= range.location >= editableRange.location;
            if (result) {
                NSString *newText = [[inputTextField text] stringByReplacingCharactersInRange:range withString:string];
                result &= [newText length] <= NSMaxRange(editableRange);
            }
        }
        else
        {
            result = range.location >= editableRange.location && range.length <= editableRange.length;
        }
    }
    
    return result;
}

@end
