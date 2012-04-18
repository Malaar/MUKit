//
//  MUTextField.h
//  MUKit
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"
#import "MUKeyboardAvoiderProtocol.h"
#import "MUInputTextFilter.h"

@class MUTextField_Holder;

@interface MUTextField : UITextField <MUValidationProtocol, UITextFieldDelegate, MUKeyboardAvoiderProtocol>
{
    MUValidator* validator;
    MUTextField_Holder* delegateHolder;
    MUInputFilter *inputTextFilter;
}

@property (nonatomic, assign) id<UITextFieldDelegate> mudelegate;
@property (nonatomic, retain) MUInputFilter *inputTextFilter;

@end
