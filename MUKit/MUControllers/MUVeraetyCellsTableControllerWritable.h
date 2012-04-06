//
//  MUVeraetyCellsTableControllerWritable.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUVeraetyCellsTableControllerReadonly.h"


@interface MUVeraetyCellsTableControllerWritable : MUVeraetyCellsTableControllerReadonly 
{
    NSMutableArray *cells;
}

- (void) didCreateCells;

@end
