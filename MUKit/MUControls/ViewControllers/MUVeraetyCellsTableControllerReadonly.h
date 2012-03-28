//
//  MUVeraetyCellsTableController.h
//  MUKit
//
//  Created by Malaar on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUBaseTableController.h"

@interface MUVeraetyCellsTableControllerReadonly : MUBaseTableController
{
    NSMutableArray* cellDataSource;

    BOOL resizedWithAnimation;
    float animationTime;
}

- (void) createCellDataSource;

@end

//==============================================================================
//==============================================================================
//==============================================================================
