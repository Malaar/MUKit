//
//  MUBOCompoundModel.m
//  MUKit
//
//  Created by Malaar on 11.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "MUBOCompoundModel.h"

@implementation MUBOCompoundModel

- (id)initWithModels:(NSArray*)aModels
{
    self = [super init];
    if(self)
    {
        _models = [aModels copy];
    }
    return self;
}

+ (NSArray*)compoundModelsFromModels:(NSArray*)aModels groupByCount:(NSUInteger)aGroupByCount
{
    NSMutableArray* result = [NSMutableArray array];

    MUBOCompoundModel* hub;
    NSArray* subarray;
    int count = aModels.count;
    for(int i = 0; i < count; i += aGroupByCount)
    {
        subarray = [aModels subarrayWithRange:NSMakeRange(i, MIN(count - i, aGroupByCount))];
        hub = [[MUBOCompoundModel alloc] initWithModels:subarray];
        [result addObject:hub];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
