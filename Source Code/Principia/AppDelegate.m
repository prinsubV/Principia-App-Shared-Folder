//
//  AppDelegate.m
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.   
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Contacts.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "Directory.h"
#import "Course1.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *viewController1, *viewController2,*viewController3, *viewController4,*viewController5, *viewController6, *viewController7;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController3 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
        viewController5 = [[Contacts alloc] initWithNibName:@"Contacts" bundle:nil];
        viewController4 = [[Directory alloc] initWithNibName:@"Directory" bundle:nil];
        viewController1 = [[FifthViewController alloc] initWithNibName:@"FifthViewController_iPhone" bundle:nil];
        viewController6 = [[SixthViewController alloc] initWithNibName:@"SixthViewController_iPhone" bundle:nil];
        viewController7 = [[Course1 alloc] initWithNibName:@"Course1" bundle:nil];
    } 
    
    else {  // for iPad
        viewController3 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
        viewController5 = [[Contacts alloc] initWithNibName:@"Contacts" bundle:nil];
        viewController4 = [[Directory alloc] initWithNibName:@"Directory" bundle:nil];
        viewController1 = [[FifthViewController alloc] initWithNibName:@"FifthViewController_iPad" bundle:nil];
        viewController6 = [[SixthViewController alloc] initWithNibName:@"SixthViewController_iPad" bundle:nil];
        viewController7 = [[Course1 alloc] initWithNibName:@"Course1" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];

    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:7];

    UINavigationController *theNavigationController;
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController1];
	[localViewControllersArray addObject:theNavigationController];

	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController2];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController3];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController4];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController7];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController6];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController5];
	[localViewControllersArray addObject:theNavigationController];

    self.tabBarController.viewControllers=localViewControllersArray;
    
//    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController7,viewController6,viewController5, nil];

//    self.navController=[[UINavigationController alloc] initWithRootViewController:self.tabBarController];
//    self.window.rootViewController = self.navController;
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
