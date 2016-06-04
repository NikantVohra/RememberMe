//
//  TrackServiceTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackService.h"

@interface TrackServiceTests : XCTestCase

@property (nonatomic, strong) TrackService *trackService;

@end

@implementation TrackServiceTests

- (void)setUp {
    [super setUp];
    self.trackService = [[TrackService alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchTracks {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *fetchTracksExpectation = [self expectationWithDescription:@"fetchTracksExpectation"];
    [self.trackService fetchTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            XCTAssertNotNil(tracks);
            XCTAssertEqual(tracks.count, 50);
        }
        [fetchTracksExpectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}



@end
