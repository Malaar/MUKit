//
//  MUKeyboardAvoidingScrollView.h
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Taken as a basis for an example of "TPKeyboardAvoidingScrollView"(Created by Michael Tyson)

#import <UIKit/UIKit.h>
#import "MUKeyboardAvoidingProtocol.h"

@interface MUKeyboardAvoidingScrollView : UIScrollView <MUKeyboardAvoidingProtocol>
{
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
    NSMutableArray *_objectsInKeyboard;
}

@end
