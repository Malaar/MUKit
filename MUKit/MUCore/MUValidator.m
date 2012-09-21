//
//  MUValidator.m
//  MUKit
//
//  Created by Malaar on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUValidator.h"

BOOL canBeInputByPhonePad(char c);

NSString* getOnlyNumbers(NSString *phoneNumber)
{
    NSMutableString *res = [[[NSMutableString alloc] init] autorelease];    
    for(int i = 0; i < [phoneNumber length]; i++) 
    {        
        char next = [phoneNumber characterAtIndex:i];        
        if(canBeInputByPhonePad(next))            
            [res appendFormat:@"%c", next];        
    }    
    return res;    
}

BOOL canBeInputByPhonePad(char c)
{
    if(c >= '0' && c <= '9') return YES;    
    return NO;    
}

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidator

@synthesize validatableObject;
@synthesize errorMessage;

//==============================================================================
- (BOOL) validate
{
    return NO;
}

//==============================================================================
- (void) dealloc
{
    [errorMessage release];
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorAny

//==============================================================================
- (BOOL) validate
{
    return YES;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorNumber

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorLetters

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^[A-Za-z]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorWords

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^([A-Za-z]| )+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorEmail

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    static NSString* mailRegExp = @"^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$";
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:mailRegExp options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorEqual

//==============================================================================
- (id) initWithTestedField:(id<MUValidationProtocol>)aTestedObject
{
    if( (self = [super init]) )
    {
        testedValidator = [[aTestedObject validator] retain];
    }
    
    return self;
}

//==============================================================================
- (id) initWithTestedFieldValidator:(MUValidator *)aTestedValidator
{
    if( (self = [super init]) )
    {
        testedValidator = [aTestedValidator retain];
    }
    
    return self;
}

//==============================================================================
- (void) dealloc
{
    [testedValidator release];
    
    [super dealloc];
}

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [validatableObject.validatableText isEqualToString:testedValidator.validatableObject.validatableText];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorNotEmpty

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [validatableObject.validatableText length] > 0;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorUSAZipCode

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText && [validatableObject.validatableText length] == 5)
    {
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    }
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorFullName

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^([A-Za-zА-Яа-я])+ ([A-Za-zА-Яа-я])+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorURL

//==============================================================================
- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^http(s)?://[a-z0-9-]+(.[a-z0-9-]+)+(:[0-9]+)?(/.*)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
    [regExp release];
    
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorIntWithRange

//==============================================================================
- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self)
    {
        range = aRange;
    }
    return self;
}

//==============================================================================
- (BOOL) validate
{
    BOOL result = NO;
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int intValue = [validatableObject.validatableText intValue];
    result = intValue >= range.location && intValue <= range.location + range.length;
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorStringWithRange

//==============================================================================
- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self)
    {
        range = aRange;
    }
    return self;
}

//==============================================================================
- (BOOL) validate
{
    BOOL result = NO;
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(validatableObject && validatableObject.validatableText && 
       [validatableObject.validatableText length] >= range.location &&
       [validatableObject.validatableText length] <= range.location + range.length)
        result = YES;
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorCountNumberInTextWithRange

//==============================================================================
- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self)
    {
        range = aRange;
    }
    return self;
}

//==============================================================================
- (BOOL) validate
{
    BOOL result = NO;
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(validatableObject && validatableObject.validatableText)
    {
        NSString *onlyNumber = getOnlyNumbers(validatableObject.validatableText);
        if (onlyNumber && [onlyNumber length] >= range.location && [onlyNumber length] <= range.location + range.length)
            result = YES;
    }
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorMoney

- (BOOL) validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];    
    NSUInteger count = 0;    
    if(validatableObject && validatableObject.validatableText)
    {    
        NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^[1-9]+([0])?(\\.[0-9]{1,2})?$" options:NSRegularExpressionCaseInsensitive error:nil];
        count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
        [regExp release];

        if (count == 0) 
        {
            regExp = [[NSRegularExpression alloc]initWithPattern:@"^[0]\\.[1-9]([0-9])?$" options:NSRegularExpressionCaseInsensitive error:nil];
            count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
            [regExp release];
        }
        
        if (count == 0)
        {
            regExp = [[NSRegularExpression alloc]initWithPattern:@"^[0]\\.[0-9][1-9]$" options:NSRegularExpressionCaseInsensitive error:nil];
            count = [regExp numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
            [regExp release];
        }
    }
    
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorRegExp

@synthesize regularExpression;

//==============================================================================
- (id) initWithRegExp:(NSRegularExpression *)aRegExp
{
    if( (self = [super init]) )
    {
        self.regularExpression = aRegExp;
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [regularExpression release];
    
    [super dealloc];
}

//==============================================================================
- (BOOL) validate
{
    BOOL result = NO;

    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(validatableObject.validatableText)
    {
        NSUInteger count = 0;
        count = [regularExpression numberOfMatchesInString:validatableObject.validatableText options:0 range:NSMakeRange(0, [validatableObject.validatableText length])];
        
        result = count == 1;
    }
    
    return result;
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUValidatorDomain

- (BOOL)validate
{
    validatableObject.validatableText = [validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSUInteger count = 0;
    if(validatableObject && validatableObject.validatableText)
    {
        NSRegularExpression* regExp = [[NSRegularExpression alloc]initWithPattern:@"^(http://|https://|[a-zA-Z0-9])(([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$"
                                                                          options:NSRegularExpressionCaseInsensitive error:nil];
        count = [regExp numberOfMatchesInString:validatableObject.validatableText
                                        options:0
                                          range:NSMakeRange(0, [validatableObject.validatableText length])];
        [regExp release];
    }
    
    return count == 1;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
