//
//  MUBOCompoundModel.h
//  MUKit
//
//  Created by Malaar on 11.02.13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUBOCompoundModel : NSObject

@property (nonatomic, readonly) NSArray* models;

- (id)initWithModels:(NSArray*)aModels;

+ (NSArray*)compoundModelsFromModels:(NSArray*)aModels groupByCount:(NSUInteger)aGroupByCount;

@end
