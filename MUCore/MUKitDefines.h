//
//  MUKitDefines.h
//  TimeLink
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define NULL_PROTECT(value) ( ((NSNull*)value == [NSNull null]) ? (nil) : (value) )
#define NILL_PROTECT(value) ( (nil == value) ? ((NSObject*)[NSNull null]) : ((NSObject*)value) )