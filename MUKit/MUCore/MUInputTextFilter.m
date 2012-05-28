//
//  MUInputTextFilter.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUInputTextFilter.h"

#pragma mark - MUInputFilter

@implementation MUInputFilter

- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end

#pragma mark - MUInputFilterNumbreValue

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

#pragma mark - MUInputFilterNumbreValueWithMaxLengthText

@implementation MUInputFilterNumbreValueWithMaxLengthText

@synthesize maxLengthText;

- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

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

#pragma mark - MUInputFilterLetterValue

@implementation MUInputFilterLetterValue

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

#pragma mark - MUInputFilterLetterValueWithMaxLengthText

@implementation MUInputFilterLetterValueWithMaxLengthText

@synthesize maxLengthText;

- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

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

#pragma mark - MUInputFilterStringWithMaxLengthText

@implementation MUInputFilterStringWithMaxLengthText

@synthesize maxLengthText;

- (id) initWithMaxLengthText:(NSUInteger)aMaxLengthText
{
    self = [super init];
    if (self)
    {
        self.maxLengthText = aMaxLengthText;
    }
    return self;
}

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

