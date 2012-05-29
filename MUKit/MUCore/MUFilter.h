//
//  MUInputTextFilter.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
/// text filter : base class
@interface MUFilter : NSObject
{
    NSUInteger maxLengthText;
}

@property (nonatomic, assign) NSUInteger maxLengthText;

- (id)initWithMaxLengthText:(NSUInteger) aMaxLengthText;
- (BOOL) filterText:(id)inputTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

//==============================================================================
/// text with only number
@interface MUFilterNumbers : MUFilter

@end

//==============================================================================
/// text with only letters
@interface MUFilterLetters : MUFilter

@end

//==============================================================================
@interface MUFilterLettersAndDigits : MUFilter

@end
