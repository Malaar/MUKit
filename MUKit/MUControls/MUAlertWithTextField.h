//
//  MUAlertWithTextField.h
//  MUKit
//
//  Created by Yuriy Bosov on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MUAlertWithTextField : UIAlertView <UITextFieldDelegate>
{
    UITextField* tfUserNameOrEmail;
}

@property (nonatomic, readonly) UITextField *textField;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles;

@end
