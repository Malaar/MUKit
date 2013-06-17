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
    NSDictionary *predefinedFormats; // available formats @"us", @"uk", @"jp, @"ru"
}

@property (nonatomic, retain) NSString* locale;

@end