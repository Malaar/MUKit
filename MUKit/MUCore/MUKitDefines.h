//
//  MUKitDefines.h
//  MUKit
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define MU_NULL_PROTECT(value) ( ((NSNull*)value == [NSNull null]) ? (nil) : (value) )
#define MU_NILL_PROTECT(value) ( (nil == value) ? ((NSObject*)[NSNull null]) : ((NSObject*)value) )

#define MU_IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define MU_CHECK_INDEX(index, min, max) {NSAssert( index >= min && index < max, @"Wrong index!");}

#define MU_IS_RETINA [UIScreen mainScreen].scale > 1.5f

#define MU_IS_OS_VERSION_ABOVE_5x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)


#ifdef DEBUG
#   define MULog(format, ...) NSLog(format, __VA_ARGS__)
#else
#   define MULog(format, ...)
#endif

#define MU_IS_IPHONE_FOUR_INCH ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0)