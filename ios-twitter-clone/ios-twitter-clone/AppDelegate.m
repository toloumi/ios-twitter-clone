//
//  AppDelegate.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "AppDelegate.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    User *user = [User currentUser];
    if (user != nil) {
        HamburgerViewController *hamburgerController = [storyboard instantiateViewControllerWithIdentifier:@"HamburgerViewController"];
        ProfileViewController *profileController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        UINavigationController *tweetsNavController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineNavController"];
        [tweetsNavController setViewControllers:@[ profileController ] animated:YES];
        MenuViewController *menuController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        
        //[hamburgerController setContentViewController:tweetsNavController];
        hamburgerController.menuViewController = menuController;
        menuController.hamburgerViewController = hamburgerController;
        
        //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:hamburgerController];
        
        self.window.rootViewController = hamburgerController;
    } else {
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [[TwitterClient sharedInstance] openUrl:url];
    return YES;
}

- (void)userDidLogout {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)onSignOut {
    [User logout];
}

@end
