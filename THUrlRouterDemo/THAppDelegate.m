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

@end
