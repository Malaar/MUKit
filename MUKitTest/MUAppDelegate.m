//
//  MUAppDelegate.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUAppDelegate.h"

#import "MURootControllerIPhone.h"
#import "MURootControllerIPad.h"
#import "MUDraw.h"

@implementation MUAppDelegate

@synthesize window = _window;
//@synthesize switchController;

- (void)dealloc
{
    [_window release];
    [switchController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MUImageWithColor([UIColor whiteColor], CGSizeMake(9, 9));
    UIViewController *viewController = nil;
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
//    // Override point for customization after application launch.
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
//    {
//        viewController = [[[MURootControllerIPad alloc] initWithNibName:@"MURootControllerIPad" bundle:nil] autorelease];
//    } else {
//        viewController = [[[MURootControllerIPhone alloc] initWithNibName:@"MURootControllerIPhone" bundle:nil] autorelease];
//    }
    viewController = [[[MURootControllerIPhone alloc] init] autorelease];
    UINavigationController* navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    
    switchController = [[MUSwitchController alloc] init];
    [switchController switchToController:navigationController animated:YES];
    
    self.window.rootViewController = switchController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
