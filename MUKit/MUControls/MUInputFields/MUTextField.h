//
//  MUTextField.h
//  MUKit
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"
#import "MUFilter.h"
#import "MUFormatter.h"
#import "MUKeyboardAvoiderProtocol.h"

@class MUTextField_Holder;

@interface MUTextField : UITextField <MUValidationProtocol, MUFormatterProtocol, UITextFieldDelegate, MUKeyboardAvoiderProtocol>
{
    MUValidator* validator;
    MUFormatter* formatter;
    MUTextField_Holder* delegateHolder;
}

@property (nonatomic, assign) id<UITextFieldDelegate> mudelegate;
@property (nonatomic, retain) MUFilter *filter;

@end
