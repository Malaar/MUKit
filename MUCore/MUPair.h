//
//  MUPair.h
//  TimeLink
//
//  Created by Malaar on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUWeakRef.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MUPair : NSObject
{
    
}

@property (nonatomic, retain) NSObject* first;
@property (nonatomic, retain) NSObject* second;

+ (id) pairWithFirst:(NSObject*)aFirst second:(NSObject*)aSecond;
- (id) initWithFirst:(NSObject*)aFirst second:(NSObject*)aSecond;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface NSArray (MUPair)

- (MUPair*) pairByFirst:(NSObject*)aFirst;
- (MUPair*) pairBySecond:(NSObject*)aSecond;

@end