//
//  MUCreditCardNumberFormatter.h
//  MUKit
//
//  Created by Yuriy Bosov on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface MUCreditCardNumberFormatter : NSObject

- (BOOL) cardFormatForTextField:(UITextField *)textField 
  shouldChangeCharactersInRange:(NSRange)range 
              replacementString:(NSString *)string 
                separatorString:(NSString *)separatorString;
@end
