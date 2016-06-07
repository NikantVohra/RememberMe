//
//  GameModelTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/5/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Game.h"
#import "Track.h"
#import "Constants.h"

@interface GameModelTests : XCTestCase

@property(nonatomic, strong) NSArray *tracks;

@end

@implementation GameModelTests

- (void)setUp {
    [super setUp];
    NSMutableArray *tracksArray = [NSMutableArray new];
    for (int i=0; i < maxTracks; i++) {
        Track *newTrack = [[Track alloc] initWithDictionary:@{@"id":@(i)}];
        [tracksArray addObject:newTrack];
    }
    self.tracks = tracksArray;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGameInitializationWithTracks {
    Game *game = [[Game alloc] initWithTracks:self.tracks];
    XCTAssertNotNil(game.tracks);
    XCTAssertEqual(game.tracks.count, maxTracks * 2);
}


@end
