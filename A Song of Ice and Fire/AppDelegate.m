//
//  AppDelegate.m
//  A Song of Ice and Fire
//
//  Created by Vicent Tsai on 15/10/25.
//  Copyright © 2015年 HeZhi Corp. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

/* Pods */
#import "YFStartView.h"
#import "OpenShareHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    mainViewController.title = @"冰与火之歌";

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    //navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
    navController.navigationBar.tintColor = [UIColor lightGrayColor];

    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // 全局注册 appId
    [OpenShare connectQQWithAppId:@"1104991968"];
    [OpenShare connectWeixinWithAppId:@"wx3e08e658d87ad516"];

    YFStartView *startView = [YFStartView startView];
    startView.randomImages = [NSMutableArray arrayWithObjects:@"launch_background", nil];
    startView.logoPosition = LogoPositionCenter;
    startView.logoImage = [UIImage imageNamed:@"launch_logo_2"];

    [startView configYFStartView];

    // Create a 1MB in-memory, 32MB disk cache
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:1*1024*1024
                                                      diskCapacity:32*1024*1024
                                                          diskPath:@"app_cache"];

    // Set the shared cache to our new instance
    [NSURLCache setSharedURLCache:cache];

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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    // 如果 OpenShare 能处理这个回调，就调用 block 中的方法，如果不能处理，就交给其他（比如支付宝）。
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
