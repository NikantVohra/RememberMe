//
//  GameManagerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/5/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameManager.h"
#import "Constants.h"
#import "Track.h"
#import <OCMock/OCMock.h>

@interface GameManager()

@property (nonatomic, assign) NSInteger selectedTrackIndex;
@property (nonatomic, strong) NSMutableDictionary *matchedTracks;

@end

@interface GameManagerTests : XCTestCase

@property(nonatomic, strong) NSArray *testTracks;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation GameManagerTests

- (void)setUp {
    [super setUp];
    Track *track1 = [[Track alloc] initWithDictionary:@{@"id" : @123, @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"}];
    Track *track2 = [[Track alloc] initWithDictionary:@{@"id" : @215, @"artwork_url" : @"https://i1.sndcdn.com/artworks-0001657432-b1vhfv-large.jpg"}];
    self.testTracks = @[track1, track2, [track1 copy], [track2 copy]];
    self.mockDelegate = OCMProtocolMock(@protocol(GameManagerDelegate));
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (GameManager *)getGameManager {
    GameManager *gameManager = [[GameManager alloc] init];
    NSMutableArray *tracksArray = [NSMutableArray new];
    for (int i=0; i < maxTracks; i++) {
        Track *newTrack = [[Track alloc] initWithDictionary:@{@"id":@(i)}];
        [tracksArray addObject:newTrack];
    }
    gameManager.currentGame = [[Game alloc] initWithTracks:tracksArray];
    gameManager.matchedTracks = [NSMutableDictionary new];
    gameManager.selectedTrackIndex = -1;
    gameManager.delegate =self.mockDelegate;
    return gameManager;
}

- (void)testStartGame {
    GameManager *gameManager = [[GameManager alloc] init];
    XCTestExpectation *startGameExpectation = [self expectationWithDescription:@"startGameExpectation"];
    [gameManager startGameWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            XCTAssertNotNil(tracks);
        }
        [startGameExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testIsTrackAlreadySelected {
    GameManager *gameManager = [self getGameManager];
    [gameManager.matchedTracks setObject:@1 forKey:@0];
    XCTAssertTrue([gameManager isTrackAlreadySelected:0]);
    XCTAssertFalse([gameManager isTrackAlreadySelected:1]);
}


- (void)testSelectTrackAtIndex {
    GameManager *gameManager = [self getGameManager];
    [gameManager selectTrackAtIndex:5];
    XCTAssertEqual(gameManager.selectedTrackIndex, 5);
}

- (void)testTracksDidMatch {
    GameManager *gameManager = [self getGameManager];
    gameManager.currentGame.tracks = self.testTracks;
    OCMExpect([self.mockDelegate gameManager:gameManager didFoundMatchAtIndex:2 withIndex:0]); //verify that diFoundMatch method was called on the delegate
    gameManager.selectedTrackIndex = 0;
    [gameManager selectTrackAtIndex:2];
    XCTAssertEqual(gameManager.selectedTrackIndex, -1); //reset the selected index on chosing same tracks
    XCTAssertNotNil([gameManager.matchedTracks objectForKey:@0]);//matchedDict contains a non nil vallue for index 0
    XCTAssertNotNil([gameManager.matchedTracks objectForKey:@2]);
    OCMVerifyAll(self.mockDelegate);

}

-(void)testTracksDidNotMatch {
    GameManager *gameManager = [self getGameManager];
    gameManager.currentGame.tracks = self.testTracks;
    OCMExpect([self.mockDelegate gameManager:gameManager didNotFindMatchAtIndex:1 withIndex:0]); //verify that didNotFindMatch method was called on the delegate
    gameManager.selectedTrackIndex = 0;
    [gameManager selectTrackAtIndex:1];
    XCTAssertEqual(gameManager.selectedTrackIndex, -1); //reset the selected index on chosing differen tracks
    XCTAssertNil([gameManager.matchedTracks objectForKey:@0]);//matchedDict contains a  nil vallue for index 0
    XCTAssertNil([gameManager.matchedTracks objectForKey:@1]);
    OCMVerifyAll(self.mockDelegate);

}

- (void)testDidEndGame {
    GameManager *gameManager = [self getGameManager];
    gameManager.currentGame.tracks = self.testTracks;
    OCMExpect([self.mockDelegate didEndGame]); //verify that end game method was called when all the matches were found
    gameManager.selectedTrackIndex = 0;
    [gameManager selectTrackAtIndex:2];
    [gameManager selectTrackAtIndex:1];
    [gameManager selectTrackAtIndex:3];
    OCMVerifyAll(self.mockDelegate);
}

- (void)testRestartGame {
    GameManager *gameManager = [self getGameManager];
    gameManager.currentGame.tracks = self.testTracks;
    gameManager.selectedTrackIndex = 0;
    [gameManager selectTrackAtIndex:2];
    [gameManager restartGame];
    XCTAssertEqual(gameManager.selectedTrackIndex, -1);
    XCTAssertEqual(gameManager.matchedTracks.allKeys.count, 0);

}

@end
