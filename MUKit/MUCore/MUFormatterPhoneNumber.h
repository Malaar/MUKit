//
//  USPhoneNumberFormatter.h
//  MUKit
//
//  Created by Yuriy Bosov on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MUFormatter.h"

@interface MUFormatterPhoneNumber : MUFormatter
{
    /**
     * available formats @"us", @"uk", @"jp, @"ru"
     **/
    NSDictionary *predefinedFormats;

    NSCharacterSet *acceptableInputCharacters;
}

@property (nonatomic, retain) NSString* locale;

/*
 * if result string after formatting is not suitable for any format of current local then return just input string
 * if value is NO then return prev formatted string before last input
 * by default is NO
 */
@property (nonatomic, assign) BOOL acceptsNotPredefinedFormattedPhoneNumber;

@end