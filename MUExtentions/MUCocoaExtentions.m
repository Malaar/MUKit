//
//  CocoaExtentions.m
//  ROM
//
//  Created by Malaar on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUCocoaExtentions.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface UIColor (Private)

- (BOOL) isRGB;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation UIColor (Extention)

//==============================================================================
+ (UIColor *)colorWithRedI:(NSInteger)red greenI:(NSInteger)green blueI:(NSInteger)blue alphaI:(NSInteger)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

//==============================================================================
- (BOOL) isRGB
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelRGB;
}

//==============================================================================
- (CGFloat) red
{
    NSAssert([self isRGB], @"Not RGB!");
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[0];
}

//==============================================================================
- (CGFloat) green
{
    NSAssert([self isRGB], @"Not RGB!");
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[1];
}

//==============================================================================
- (CGFloat) blue
{
    NSAssert([self isRGB], @"Not RGB!");
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[2];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation UIView (Extention)

- (UIViewController *) firstAvailableUIViewController
{
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController
{
    id result = nil;
    
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([nextResponder isKindOfClass:[UIView class]])
        result = [nextResponder traverseResponderChainForUIViewController];
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation NSString (Extention)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    NSString* result = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                            NULL,
                                            (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                            CFStringConvertNSStringEncodingToEncoding(encoding));
    return [result autorelease];
}

-(NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding
{
    NSString* result = (NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self,
                                                            CFSTR(""),
                                                            CFStringConvertNSStringEncodingToEncoding(encoding));
    return [result autorelease];
}

@end
