//
//  MUKeyboardAvoidingScrollView.h
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Taken as a basis for an example of "TPKeyboardAvoidingScrollView"(Created by Michael Tyson)

#import <UIKit/UIKit.h>

@interface MUKeyboardAvoidingScrollView : UIScrollView
{
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
    NSMutableArray *_objectsInKeyboard;
}

- (void)adjustOffset;
- (void)hideKeyBoard;
- (void)addObjectForKeyboard:(id<UITextInputTraits>)objectForKeyboard;
- (void)addObjectsForKeyboard:(NSArray *)objectsForKeyboard;
- (void)responderShouldReturn:(UIResponder*)aResponder;

@end
