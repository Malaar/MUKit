//
//  MUWeakRef.m
//  MUKit
//
//  Created by Malaar on 14.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUWeakRef.h"


@implementation MUWeakRef

@dynamic object;

- (id) initWithObject:(NSObject<MUWeakRefProtocol>*) aObject
{
	if( (self = [super init]) )
	{
		object = aObject;	// weak ref
	}
	
	return self;
}

- (void) invalidate
{
	@synchronized(self)
	{
		object = nil;
	}
}

- (NSObject<MUWeakRefProtocol>*) object
{
	@synchronized(self)
	{
		return [[object retain] autorelease];
	}
}

@end
