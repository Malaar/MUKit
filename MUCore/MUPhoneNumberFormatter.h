//
//  USPhoneNumberFormatter.h
//  MUKit
//
//  Created by Yuriy Bosov on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUPhoneNumberFormatter : NSObject
{
    NSDictionary *predefinedFormats;    
}

- (id)init;

- (BOOL)phoneFormatForTextField:(UITextField *)textField
  shouldChangeCharactersInRange:(NSRange)range 
              replacementString:(NSString *)string
                     withLocale:(NSString *)locale;

/* 
 Attemps to format the phone number to the specified locale. 
 */
- (NSString *)format:(NSString *)phoneNumber withLocale:(NSString *)locale;

/*
 Strips the input string from characters added by the formatter. 
 Namely, it removes any character that couldn't have been entered by the user. 
 */
- (NSString *)strip:(NSString *)phoneNumber;

/* 
 Returns true if the character comes from a phone pad. 
 */
- (BOOL)canBeInputByPhonePad:(char)c;

@end
