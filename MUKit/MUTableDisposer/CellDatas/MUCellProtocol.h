//
//  MUCellProtocol.h
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MUKitTest_MUCellProtocol_h
#define MUKitTest_MUCellProtocol_h

#import "MUCellData.h"

@protocol MUCellProtocol <NSObject>

@property (nonatomic, readonly) MUCellData *cellData;

- (void) setupCellData:(MUCellData *) aCellData;

@end

#endif
