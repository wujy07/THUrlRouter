//
//  THUrlRouter.m
//  THUrlRouterTest
//
//  Created by Junyan Wu on 16/12/7.
//  Copyright © 2016年 THU. All rights reserved.
//

#import "THUrlRouter.h"
#import <UIKit/UIKit.h>

static NSMutableDictionary *kMetaUrlGeneratorMap;
static NSString *kScheme;

@implementation THUrlRouter

+ (void)configureScheme:(NSString *)scheme {
    kScheme = scheme;
}

+ (void)registerUrl:(NSString *)urlString forControllerGenerator:(THControllerGenerator)generator {
    NSAssert(kScheme, @"please configure scheme");
    
    urlString = [[kScheme stringByAppendingString:@"://"] stringByAppendingString:urlString];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    if (!kMetaUrlGeneratorMap) {
        kMetaUrlGeneratorMap = [NSMutableDictionary dictionary];
    }
    [kMetaUrlGeneratorMap setObject:generator forKey:url];
}

+ (UIViewController *)viewControllerFromURL:(NSURL *)url {
    if (![url.scheme isEqualToString:kScheme]) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj.name;
        NSString *value = obj.value;
        [params setObject:value forKey:key];
    }];
    __block BOOL isFindMatch = NO;
    NSURL *metaUrl;
    for (metaUrl in kMetaUrlGeneratorMap.allKeys) {
        if (metaUrl.pathComponents.count != url.pathComponents.count) {
            continue;
        }
        if (![metaUrl.host isEqualToString:url.host]) {
            continue;
        }
        NSUInteger count = metaUrl.pathComponents.count;
        [metaUrl.pathComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj hasPrefix:@":"]) {
                if (![obj isEqualToString:[url.pathComponents objectAtIndex:idx]]) {
                    *stop = YES;
                }
            } else {
                NSString *key = [obj substringFromIndex:1];
                NSString *value = [url.pathComponents objectAtIndex:idx];
                [params setObject:value forKey:key];
                if (idx == count - 1) {
                    isFindMatch = YES;
                }
            }
        }];
        if (isFindMatch) {
            break;
        }
    }
    if (!isFindMatch) {
        return nil;
    }
    THControllerGenerator generator = [kMetaUrlGeneratorMap objectForKey:metaUrl];
    if (generator) {
        UIViewController *vc = generator(params);
        return vc;
    }
    return nil;
}

@end

