//
//  MUTLBaseScrollerController.h
//  MUKit
//
//  Created by Yuriy Bosov on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUBaseViewController.h"

@interface MUBaseScrollerController : MUBaseViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView* scrollView;
}

- (CGSize) getContentSizeForScrollView;
- (Class) scrollViewClass;

- (UIImage*) backgraundImageForScrollView;

@end
