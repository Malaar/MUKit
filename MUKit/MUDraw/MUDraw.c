//
//  MUDraw.c
//  Medline
//
//  Created by Malaar on 04.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "MUDraw.h"

//==============================================================================
void MUDrawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, bool isHorizontal)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0f, 1.0f};
    CGColorRef colors_c[2] = {startColor, endColor};
    CFArrayRef colors = CFArrayCreate(NULL, (const void**)colors_c, 2, &kCFTypeArrayCallBacks);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    
    CGPoint startPoint;
    CGPoint endPoint;
    if(isHorizontal)
    {
        startPoint = CGPointMake(rect.origin.x, rect.origin.y);
        endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    }
    else
    {
        startPoint = CGPointMake(rect.origin.x, rect.origin.y);
        endPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    }
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);

    CFRelease(colors);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

//==============================================================================
void MUDrawLinearGradientVertical(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    MUDrawLinearGradient(context, rect, startColor, endColor, true);
}

//==============================================================================
void MUDrawLinearGradientHorizontal(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    MUDrawLinearGradient(context, rect, startColor, endColor, false);
}

//==============================================================================
CGContextRef MUCreateThreadSafeContext(CGSize contextSize)
{
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,
                                                 (int)contextSize.width,
                                                 (int)contextSize.height,
                                                 8,
                                                 0,
                                                 space,
                                                 kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(space);
    return context;
}

//==============================================================================
CGImageRef MUCreateCGImageFromThreadSafeContext(CGContextRef context)
{
    return CGBitmapContextCreateImage(context);
}
