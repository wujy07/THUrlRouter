//
//  THUrlRouter.h
//  THUrlRouterTest
//
//  Created by Junyan Wu on 16/12/7.
//  Copyright © 2016年 THU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

typedef UIViewController *(^THControllerGenerator)(NSDictionary *params);

@interface THUrlRouter : NSObject

+ (void)configureScheme:(NSString *)scheme;
+ (void)registerUrl:(NSString *)urlString forControllerGenerator:(THControllerGenerator)generator;
+ (UIViewController *)viewControllerFromURL:(NSURL *)url;

@end
