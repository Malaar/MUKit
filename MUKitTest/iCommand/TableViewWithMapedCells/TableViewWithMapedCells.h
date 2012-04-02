//
//  TableViewWithMapedCells.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUBaseViewController.h"
#import "MUTableDisposerMaped.h"

@interface TableViewWithMapedCells : MUBaseViewController <MUTableDisposerDelegate>
{
    MUTableDisposerMaped* tableDisposer;
}

@end
