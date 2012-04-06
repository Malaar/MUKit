//
//  MUAppDelegate.h
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUSwitchController.h"


@interface MUAppDelegate : UIResponder <UIApplicationDelegate>
{
    MUSwitchController* switchController;
}

@property (strong, nonatomic) UIWindow *window;
//@property (retain, nonatomic) MUSwitchController* switchController;

@end
