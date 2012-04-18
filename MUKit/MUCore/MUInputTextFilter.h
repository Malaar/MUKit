//
//  MUInputTextFilter.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
/// text filter : base class
@interface MUInputFilter : NSObject

- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only number
@interface MUInputFilterNumbreValue : MUInputFilter

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only numbers, numbers value has max
@interface MUInputFilterNumbreValueWithMaxLengthText : MUInputFilterNumbreValue

@property (nonatomic, assign) NSUInteger maxLengthText;

- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only letters
@interface MUInputFilterLetterValue : MUInputFilter

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text with only letters, text has limited the length
@interface MUInputFilterLetterValueWithMaxLengthText : MUInputFilterLetterValue

@property (nonatomic, assign) NSUInteger maxLengthText;

- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

//==============================================================================
//==============================================================================
//==============================================================================
/// text has limited the length
@interface MUInputFilterStringWithMaxLengthText : MUInputFilter

@property (nonatomic, assign) NSUInteger maxLengthText;

- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;

@end

