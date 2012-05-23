//
//  MUWeakRef.h
//  MUKit
//
//  Created by Malaar on 14.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// Based on http://stackoverflow.com/questions/1072541/i-have-a-circular-reference-how-can-i-create-a-weak-reference-in-objective-c

#import <Foundation/Foundation.h>


@class MUWeakRef;

/**
 `MUWeakRefProtocol` interface made for using in `MUWeakRef` class.
 */
@protocol MUWeakRefProtocol <NSObject>

- (MUWeakRef*) weakReference;

@end


/**
 `MUWeakRef` made for awoding circular references.
 
 ## Base Description
 
 Using assign to create weak references can be unsafe in a multithreaded system, particularly when either object can be retained by a third object, and then used to dereference the other object.
 
 Fortunately, this is often a problem of hierarchy, and the object containing the weak reference only cares about the object it refers to for the referred-to object's lifetime. This is the usual situation with a Superior<->Subordinate relationship.
 
 ## Some advantages
 
 It's thread safe. There is no way you can have the weak reference contained in Subordinate become an invalid pointer. It may become nil but that is OK.
 Only the objects themselves need to know about the embedded weak reference. All other objects can treat Subordinate as if it has a regular reference to Superior.
 
 */
@interface MUWeakRef : NSObject
{
	@private
	NSObject<MUWeakRefProtocol>* object;
}

@property (readonly) NSObject<MUWeakRefProtocol>* object;

///---------------------------------------
/// @name Main methods
///---------------------------------------

/**
 Creates and initializes an `MUWeakRef` object with the specified weak reference.
 
 @param object that corresponds to `MUWeakRefProtocol`
 
 @return The newly-initialized object with weak reference
 */
- (id) initWithObject:(NSObject<MUWeakRefProtocol>*) aObject;

/**
 Clear weak referenced object
 */
- (void) invalidate;

@end

