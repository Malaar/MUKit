//
//  NSString+Base64Encoding.h
//  MUKit
//
//  Created by Malaar on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Base64Encoding)

+ (NSString *) base64StringFromData: (NSData *)data length: (int)length;

@end
