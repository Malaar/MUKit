//
//  MUPopovedStrategy.h
//  MUKit
//
//  Created by Malaar on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUPopoverable.h"

@interface MUPopovedStrategy : NSObject

@property (nonatomic, assign) Class popoverBackgroundViewClass;

@property (nonatomic, retain, readonly) UIView* popovedView;
@property (nonatomic, retain, readonly) UIPopoverController *popoverController;
@property (nonatomic, assign, readonly) UIPopoverArrowDirection permittedArrowDirections;


- (void) presentPopoverFromView:(UIView*)aView
            withContentController:(UIViewController<MUPopoverable>*)aPopoverableController
         permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                         animated:(BOOL)animated;

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

@end
