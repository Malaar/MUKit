//
//  MUTextField.h
//  ROM
//
//  Created by Malaar on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUTextField.h"

@interface MUTextFieldPadding : MUTextField
{
}

+ (id) textFieldPaddingWithBG:(UIImage*)aBG padding:(int)aPadding;
- (id) initWithBG:(UIImage*)aBG padding:(int)aPadding;

- (void) setPadding:(int)aPadding;

@end
