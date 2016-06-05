//
//  GameManagerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/5/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameManager.h"

@interface GameManagerTests : XCTestCase

@property(nonatomic, strong) GameManager *gameManager;

@end

@implementation GameManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.gameManager = [[GameManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStartGame {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *startGameExpectation = [self expectationWithDescription:@"startGameExpectation"];
    [self.gameManager startGameWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            XCTAssertNotNil(tracks);
        }
        [startGameExpectation fulfill];
    }];
}



@end
