//
//  MUWeakRef.h
//  TimeLink
//
//  Created by Malaar on 14.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// Based on http://stackoverflow.com/questions/1072541/i-have-a-circular-reference-how-can-i-create-a-weak-reference-in-objective-c

#import <Foundation/Foundation.h>


@class MUWeakRef;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol MUWeakRefProtocol <NSObject>

- (MUWeakRef*) weakReference;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUWeakRef : NSObject
{
	@private
	NSObject<MUWeakRefProtocol>* object;
}

@property (readonly) NSObject<MUWeakRefProtocol>* object;

- (id) initWithObject:(NSObject<MUWeakRefProtocol>*) aObject;
- (void) invalidate;

@end

//==============================================================================
//==============================================================================
//==============================================================================
