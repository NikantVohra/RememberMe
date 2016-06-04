//
//  TrackModelTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Track.h"

@interface TrackModelTests : XCTestCase

@end

@implementation TrackModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTrackInitialisationFromDictionary {
    NSDictionary *trackDictionary = @{@"id" : @"267291077", @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"};
    Track *track = [[Track alloc] initWithDictionary:trackDictionary];
    XCTAssertEqualObjects(track.trackId, @"267291077");
    XCTAssertEqualObjects(track.artworkUrl, @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg");
}



@end
