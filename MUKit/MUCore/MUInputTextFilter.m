//
//  MUInputTextFilter.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUInputTextFilter.h"

//==============================================================================
//==============================================================================
//==============================================================================
/// text filter : base class
@implementation MUInputFilter

- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only number
@implementation MUInputFilterNumbreValue

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
    if ([string length] > 0)
    {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) 
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    else
    {
        result = YES;
    }
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only numbers, numbers value has max and min
@implementation MUInputFilterNumbreValueWithMaxLengthText

//==============================================================================
@synthesize maxLengthText;

//==============================================================================
- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
    if ([string length] > 0)
    {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound && [[inputTextField text] length] < maxLengthText) 
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    else
    {
        result = YES;
    }
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only letters
@implementation MUInputFilterLetterValue

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
    if ([string length] > 0)
    {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) 
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    else
    {
        result = YES;
    }
    
    return result;
}


@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only letters, text has limited the length
@implementation MUInputFilterLetterValueWithMaxLengthText

//==============================================================================
@synthesize maxLengthText;

//==============================================================================
- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
    if ([string length] > 0)
    {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound && [[inputTextField text] length] < maxLengthText) 
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    else
    {
        result = YES;
    }
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text has limited the length
@implementation MUInputFilterStringWithMaxLengthText

//==============================================================================
@synthesize maxLengthText;

//==============================================================================
- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

//==============================================================================
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
    if ([string length] > 0)
    {
        if ([[inputTextField text] length] < maxLengthText) 
        {
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    else
    {
        result = YES;
    }
    
    return result;
}

@end

