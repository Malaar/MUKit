//
//  CocoaExtentions.h
//  MUKit
//
//  Created by Malaar on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Extention)

+ (UIColor *)colorWithRedI:(NSInteger)red greenI:(NSInteger)green blueI:(NSInteger)blue alphaI:(NSInteger)alpha;
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;


@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface UIView (Extention)

- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface NSString (Extention)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
-(NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

@end