//
//  NSString+Base64Encoding.h
//  Privatext
//
//  Created by Maxim Letushov on 5/24/11.
//  Copyright 2011 Dimalex. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Base64Encoding)

+ (NSString *) base64StringFromData: (NSData *)data length: (int)length;

@end
