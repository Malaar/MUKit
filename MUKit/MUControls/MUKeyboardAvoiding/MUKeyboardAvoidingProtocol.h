//
//  MUKeyboardAvoidingProtocol.h
//  MUKitTest
//
//  Created by Malaar on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MUKeyboardAvoiderProtocol;

@protocol MUKeyboardAvoidingProtocol <NSObject>

- (void)adjustOffset;
- (void)hideKeyBoard;
- (void)addObjectForKeyboard:(id<UITextInputTraits, MUKeyboardAvoiderProtocol>)objectForKeyboard;
- (void)addObjectsForKeyboard:(NSArray *)objectsForKeyboard;
- (void)responderShouldReturn:(UIResponder*)aResponder;

@end
