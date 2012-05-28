//
//  MUValidator.h
//  MUKit
//
//  Created by Malaar on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* getOnlyNumbers(NSString *phoneNumber);

@class MUValidator;

/**
 `MUValidationProtocol` is an interface made for `MUValidator`.
 
 ## Interface Methods
 
 - `setValidator:`
 - `validator`
 - `validate`

 @warning Object that supports this protocol should also have property `validatableText`
 
 */
@protocol MUValidationProtocol <NSObject>

@property (nonatomic, assign) NSString* validatableText;
- (void) setValidator:(MUValidator*)aValidator;
- (MUValidator*) validator;
- (BOOL) validate;

@end


/**
 `MUValidator` is an `NSObject` subclass that used for validate text in Text Field and Text View.
 
 ## Subclassing Notes

 The main method of this calss is -`validate` so for subclassing this class this method should be overriden to change validation behavior.
 
 */
@interface MUValidator : NSObject
{
    id<MUValidationProtocol> validatableObject;
    NSString *errorMessage;
}

/**
 Object that supports `MUValidationProtocol`. It will be used for validation.
 */
@property (nonatomic, assign) id<MUValidationProtocol> validatableObject;
/**
 Specified text that should be shown in Alert View if validation process fails.
 */
@property (nonatomic, retain) NSString *errorMessage;

/**
 Validate `validatableObject` if it was set.
 
 @return YES if validatableObject passed validation process. 
 */
- (BOOL) validate;

@end


/**
 `MUValidatorAny` is an `MUValidator` subclass that returns YES for any validationableObject.
 
 */
@interface MUValidatorAny : MUValidator
{
}
@end


/**
 `MUValidatorNumber` is an `MUValidator` subclass that validate Text Field for allowed only numbers
 
 */
@interface MUValidatorNumber : MUValidator
{
}
@end

/**
 `MUValidatorLetters` is an `MUValidator` subclass that validate Text Field for allowed only English letters
 
 */
@interface MUValidatorLetters : MUValidator
{
}
@end

/**
 `MUValidatorWords` is an `MUValidator` subclass that validate Text Field for allowed only English words
 
 */
@interface MUValidatorWords : MUValidator
{
}
@end

/**
 `MUValidatorEmail` is an `MUValidator` subclass that validate Text Field for allowed only email format strings
 
 */
@interface MUValidatorEmail : MUValidator
{
}
@end

/**
 `MUValidatorEmail` is an `MUValidator` subclass that validate Text Field for allowed only if validatableObject value equels value of aTestedField
 
 */
@interface MUValidatorEqual : MUValidator
{
    MUValidator *testedValidator;
}

///---------------------------------------
/// @name Main methods
///---------------------------------------

/**
 Creates and initializes an `MUValidatorIntWithRange` object with the specified Tested Text Field.
 
 @param Tested Text Field that support `MUValidationProtocol`
 
 @return The newly-initialized validator object with aTestedField
 */
- (id) initWithTestedField:(id<MUValidationProtocol>)aTestedObject;

/**
 Creates and initializes an `MUValidatorIntWithRange` object with the specified Tested Validator.
 
 @param Tested Validator object of class `MUValidator`
 
 @return The newly-initialized validator object with Tested Validator
 */
- (id) initWithTestedFieldValidator:(MUValidator *)aTestedValidator;

@end

/**
 `MUValidatorNotEmpty` is an `MUValidator` subclass that validate Text Field for emtpiness not allowed
 
 */
@interface MUValidatorNotEmpty : MUValidator
{
}
@end

/**
 `MUValidatorUSAZipCode` is an `MUValidator` subclass that validate Text Field for allowed only USA Zip format strings
 
 */
@interface MUValidatorUSAZipCode : MUValidator
{
}
@end

/**
 `MUValidatorFullName` is an `MUValidator` subclass that validate Text Field for allowed only _full name_ format strings
 
 @warning full name consist of first name ' ' lastName
 */
@interface MUValidatorFullName : MUValidator
{
}
@end

/**
 `MUValidatorURL` is an `MUValidator` subclass that validate Text Field for allowed only URL format strings
 
 */
@interface MUValidatorURL : MUValidator
{
}
@end

/**
 `MUValidatorIntWithRange` is an `MUValidator` subclass that validate Text Field for allowed only numbers with specified range.
 
 */ 
@interface MUValidatorIntWithRange : MUValidator
{
    NSRange range;
}

///---------------------------------------
/// @name Main methods
///---------------------------------------

/**
 Creates and initializes an `MUValidatorIntWithRange` object with the specified range.
 
 @param object of `NSRange` class
 
 @return The newly-initialized validator object with range
 */
- (id) initWithRange:(NSRange)aRange;

@end

/**
 `MUValidatorStringWithRange` is an `MUValidator` subclass that validate Text Field for allowed strings with specified range.
 
 */
@interface MUValidatorStringWithRange : MUValidator
{
    NSRange range;
}

///---------------------------------------
/// @name Main methods
///---------------------------------------

/**
 Creates and initializes an `MUValidatorIntWithRange` object with the specified range.
 
 @param object of `NSRange` class
 
 @return The newly-initialized validator object with range
 */
- (id) initWithRange:(NSRange)aRange;

@end

/**
 `MUValidatorCountNumberInTextWithRange` is an `MUValidator` subclass that validate Text Field for allowed only phone format strings.
 
 @warning Exemple: validation count number in phone number (050)-50-50-500
 */
@interface MUValidatorCountNumberInTextWithRange : MUValidator
{
    NSRange range;
}

///---------------------------------------
/// @name Main methods
///---------------------------------------

/**
 Creates and initializes an `MUValidatorIntWithRange` object with the specified range.
 
 @param object of `NSRange` class
 
 @return The newly-initialized validator object with range
 */
- (id) initWithRange:(NSRange)aRange;

@end


/**
 `MUValidatorMoney` is an `MUValidator` subclass that validate Text Field for allowed only money format strings.
 
 */
@interface MUValidatorMoney : MUValidator
{
    
}

@end
