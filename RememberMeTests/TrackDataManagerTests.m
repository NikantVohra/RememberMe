//
//  TrackDataManagerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackDataManager.h"
#import "Track.h"

@interface TrackDataManagerTests : XCTestCase

@property(nonatomic, strong) TrackDataManager *dataManager;

@end

@implementation TrackDataManagerTests

- (void)setUp {
    [super setUp];
    self.dataManager = [[TrackDataManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetTracksList{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *getTrackListExpectation = [self expectationWithDescription:@"fetchTracksExpectation"];
    [self.dataManager getTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            XCTAssertNotNil(tracks, @"Tracks should not be nil");
            XCTAssertGreaterThan(tracks.count, 0, @"Fetched tracks count should be greater than 0");
            XCTAssertTrue([tracks[0] isKindOfClass:[Track class]], @"Array object should be of type Track");
        }
        [getTrackListExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}



@end
