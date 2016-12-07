//
//  THUrlRouterDemoTests.m
//  THUrlRouterDemoTests
//
//  Created by Junyan Wu on 16/12/7.
//  Copyright © 2016年 THU. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "THUrlRouter.h"
#import "THUrlRouterTestsViewController.h"

@interface THUrlRouterDemoTests : XCTestCase

@end

@implementation THUrlRouterDemoTests

- (void)setUp {
    [super setUp];
    [THUrlRouter registerUrl:@"demotests/:title" forControllerGenerator:^UIViewController *(NSDictionary *params) {
        THUrlRouterTestsViewController *vc = [[THUrlRouterTestsViewController alloc] init];
        vc.params = params;
        return vc;
    }];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    THUrlRouterTestsViewController *vc = (THUrlRouterTestsViewController *)[THUrlRouter viewControllerFromURL:[NSURL URLWithString:@"thu://demotests/heihei?id=hehe&name=haha"]];
    NSString *title = [vc.params objectForKey:@"title"];
    NSString *idd = [vc.params objectForKey:@"id"];
    NSString *name = [vc.params objectForKey:@"name"];
    XCTAssertTrue([title isEqualToString:@"heihei"]);
    XCTAssertTrue([idd isEqualToString:@"hehe"]);
    XCTAssertTrue([name isEqualToString:@"haha"]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

@end
