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
    if( (self = [super init]) )
    {
        maxLengthText = NSNotFound;
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
//    result &= [[inputTextField text] length] < maxLengthText;
    return YES;
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