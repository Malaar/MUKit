//
//  MUCellDataModeled.h
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"

@interface MUCellDataModeled : MUCellData

@property (nonatomic, readonly) id model;

- (id) initWithModel:(id)aModel;

@end
