//
//  MUKeyboardAvoidingTableView.h
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Taken as a basis for an example of "TPKeyboardAvoidingTableView"(Created by Michael Tyson)

#import <UIKit/UIKit.h>
#import "MUKeyboardAvoidingProtocol.h"
#import "MUKeyboardToolbar.h"

@interface MUKeyboardAvoidingTableView : UITableView <MUKeyboardAvoidingProtocol, MUKeyboardToolbarProtocol>
{
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    NSMutableArray *_objectsInKeyboard;
    
    NSUInteger _selectIndexInputField;    
    MUKeyboardToolbar *keyboardToolbar;
}

@end
