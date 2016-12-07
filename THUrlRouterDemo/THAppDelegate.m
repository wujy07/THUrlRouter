//
//  THAppDelegate.m
//  test4
//
//  Created by Junyan Wu on 16/12/6.
//  Copyright © 2016年 THU. All rights reserved.
//

#import "THAppDelegate.h"
#import "THViewController.h"
#import "THUrlRouter.h"

@interface THAppDelegate ()

@property (nonatomic, strong) UINavigationController *rootVC;

@end

@implementation THAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerUrls];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    THViewController *vc = [[THViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)registerUrls {
    [THUrlRouter configureScheme:@"thu"];
    [THUrlRouter registerUrl:@"test1/:title" forControllerGenerator:^UIViewController *(NSDictionary *params) {
        NSString *title = [params objectForKey:@"title"];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = title;
        NSLog(@"%@", params);
        return vc;
    }];
    [THUrlRouter registerUrl:@"test2/:title" forControllerGenerator:^UIViewController *(NSDictionary *params) {
        NSString *title = [params objectForKey:@"title"];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor redColor];
        vc.title = title;
        NSLog(@"%@", params);
        return vc;
    }];
    [THUrlRouter registerUrl:@"test3/:title" forControllerGenerator:^UIViewController *(NSDictionary *params) {
        NSString *title = [params objectForKey:@"title"];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor greenColor];
        vc.title = title;
        NSLog(@"%@", params);
        return vc;
    }];
}

//handle url link

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [self application:app handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self application:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.scheme isEqualToString:@"thu"]) {
        UIViewController *vc = [THUrlRouter viewControllerFromURL:url];
        [self.rootVC pushViewController:vc animated:YES];
        return YES;
    }
    return NO;
}

- (UINavigationController *)rootVC {
    return (UINavigationController *)self.window.rootViewController;
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


@end
