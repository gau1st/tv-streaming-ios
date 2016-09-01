//
//  AppDelegate.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"

#import "NavigationViewController.h"

#import "CountryViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    NSLog(@"My Device IS : %@", deviceType);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Create Our Navigation Controller Object
    NavigationViewController *navController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        navController = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController_iPhone" bundle:Nil];
    } else {
        navController = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController_iPhone" bundle:Nil];
    }

    
    //Create Our Nationality Controller List Object
    // CountryViewController *countryController;
    NavigationViewController *nav2Controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nav2Controller = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController_iPhone" bundle:Nil];
        nav2Controller.fromCountry = YES;
        
        nav2Controller.country = @"Indonesia";
        nav2Controller.idCountry = @"50b5bc7e47aa3900380008e8";
        
    } else {
        nav2Controller = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController_iPhone" bundle:Nil];
        
        nav2Controller.fromCountry = YES;
        
        nav2Controller.country = @"Indonesia";
        nav2Controller.idCountry = @"50b5bc7e47aa3900380008e8";
    }
    
    //Create Our UINavigationController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:navController];
    //UINavigationController *nationality = [[UINavigationController alloc] initWithRootViewController:countryController];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:nav2Controller];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav2, nav];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
