//
//  MUKeyboardAvoidingProtocol.h
//  MUKitTest
//
//  Created by Malaar on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUKeyboardToolbar.h"

@protocol MUKeyboardAvoiderProtocol;

@protocol MUKeyboardAvoidingProtocol <NSObject>

@property (nonatomic, readonly) MUKeyboardToolbar *keyboardToolbar;
@property (nonatomic, assign) BOOL keyboardToolbarShow;

- (void)adjustOffset;
- (void)hideKeyBoard;
- (void)addObjectForKeyboard:(id<UITextInputTraits, MUKeyboardAvoiderProtocol>)objectForKeyboard;
- (void)addObjectsForKeyboard:(NSArray *)objectsForKeyboard;
- (void)responderShouldReturn:(UIResponder*)aResponder;

@end
