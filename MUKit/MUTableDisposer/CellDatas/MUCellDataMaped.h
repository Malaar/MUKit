//
//  MUCellDataMaped.h
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"

@interface MUCellDataMaped : MUCellData
{
    NSString *key;
    NSObject *object;
}

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) NSObject *object;

- (id) initWithObject:(NSObject *)aObject key:(NSString *)aKey;
- (void) setup;

- (void) mapFromObject;
- (void) mapToObject;

@end
