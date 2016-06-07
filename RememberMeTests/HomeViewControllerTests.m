//
//  HomeViewControllerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/7/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "HomeViewController.h"

@interface HomeViewControllerTests : XCTestCase

@end

@implementation HomeViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNibLoading {
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    // Trigger view did load:
    UIView *view = homeViewController.view;
    XCTAssertNotNil(view, @"");
}



@end
