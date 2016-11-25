//
//  AppDelegate.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AppDelegate.h"

#import "XTLoginViewController.h"
#import "XTGameWorldTableViewController.h"


#pragma mark -

@interface AppDelegate ()

@end


#pragma mark -

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self registerNotifications];
    
    XTLoginViewController *loginViewController = [[XTLoginViewController alloc] initWithNibName:@"XTLoginViewController" bundle:nil];
    self.window.rootViewController = loginViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark Private methods

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showGameWorlds)
                                                 name:@"XTNotifcationsLogInNotificationKey"
                                               object:nil];
}

- (void)showGameWorlds {
    XTGameWorldTableViewController *viewController = [[XTGameWorldTableViewController alloc] initWithNibName:@"XTGameWorldTableViewController" bundle:nil];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = nav;
}


@end
