//
//  MUInputTextFilter.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `MUInputFilter` is an `NSObject` that used for filtering input info in text fields and text views.
 
 @warning It's base class and should be subclassed for implenting some specified filters

 */
@interface MUInputFilter : NSObject

///-------------------------------
/// @name Main filter Methods
///-------------------------------

/**
 Should return `YES` if replacementString correspons to filter allowed input.
 */
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

/**
 `MUInputFilterNumbreValue` is an `MUInputFilter` that allows to input only numbers.
 
 */
@interface MUInputFilterNumbreValue : MUInputFilter

///-------------------------------
/// @name Main filter Methods
///-------------------------------

@end

/**
 `MUInputFilterNumbreValueWithMaxLengthText` is an `MUInputFilterNumbreValue` that allows to input only numbers and input string should be less than specified maximum length.
 
 */
@interface MUInputFilterNumbreValueWithMaxLengthText : MUInputFilterNumbreValue

@property (nonatomic, assign) NSUInteger maxLengthText;

///-------------------------------
/// @name Initialization Input Filter Methods
///-------------------------------

/**
 Creates and initializes an `MUInputFilterNumbreValueWithMaxLengthText` object with the specified maximum text's length.
 
 @param maximum length of allowed input text
 
 @return The newly-initialized Input Filter
 */
- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

/**
 `MUInputFilterLetterValue` is an `MUInputFilter` that allows to input only letters.
 
 */
@interface MUInputFilterLetterValue : MUInputFilter

///-------------------------------
/// @name Main filter Methods
///-------------------------------

@end

/**
 `MUInputFilterLetterValueWithMaxLengthText` is an `MUInputFilterLetterValue` that allows to input only letters and input string should be less than specified maximum length.
 
 */
@interface MUInputFilterLetterValueWithMaxLengthText : MUInputFilterLetterValue

@property (nonatomic, assign) NSUInteger maxLengthText;

///-------------------------------
/// @name Initialization Input Filter Methods
///-------------------------------

/**
 Creates and initializes an `MUInputFilterLetterValueWithMaxLengthText` object with the specified maximum text's length.
 
 @param maximum length of allowed input text
 
 @return The newly-initialized Input Filter
 */
- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

/**
 `MUInputFilterStringWithMaxLengthText` is an `MUInputFilter` that allows to input any characters and input string should be less than specified maximum length.
 
 */
@interface MUInputFilterStringWithMaxLengthText : MUInputFilter

@property (nonatomic, assign) NSUInteger maxLengthText;

///-------------------------------
/// @name Initialization Input Filter Methods
///-------------------------------

/**
 Creates and initializes an `MUInputFilterStringWithMaxLengthText` object with the specified maximum text's length.
 
 @param maximum length of allowed input text
 
 @return The newly-initialized Input Filter
 */
- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

