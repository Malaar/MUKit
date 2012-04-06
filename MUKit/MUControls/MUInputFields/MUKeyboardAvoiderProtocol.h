//
//  MUKeyboardAvoiderProtocol.h
//  MUKitTest
//
//  Created by Malaar on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MUKeyboardAvoidingProtocol;

@protocol MUKeyboardAvoiderProtocol <NSObject>

@property (nonatomic, assign) id<MUKeyboardAvoidingProtocol> keyboardAvoiding;

@end
