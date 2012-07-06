//
//  MUDraw.h
//  Medline
//
//  Created by Malaar on 04.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Medline_MUDraw_h
#define Medline_MUDraw_h

#import <QuartzCore/QuartzCore.h>

extern void MUDrawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, bool isHorizontal);
extern void MUDrawLinearGradientVertical(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
extern void MUDrawLinearGradientHorizontal(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);

extern CGContextRef MUCreateThreadSafeContext(CGSize contextSize);
extern CGImageRef MUCreateCGImageFromThreadSafeContext(CGContextRef context);

extern UIImage* MUImageWithColor(UIColor* color, CGSize size);

#endif
