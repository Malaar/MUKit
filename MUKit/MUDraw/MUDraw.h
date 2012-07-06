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

inline void MUDrawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, bool isHorizontal);
inline void MUDrawLinearGradientVertical(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
inline void MUDrawLinearGradientHorizontal(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);

inline CGContextRef MUCreateThreadSafeContext(CGSize contextSize);
inline CGImageRef MUCreateCGImageFromThreadSafeContext(CGContextRef context);

#endif
