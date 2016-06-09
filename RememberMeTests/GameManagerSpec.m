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
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>


@interface GameManager()

@property (nonatomic, assign) NSInteger selectedTrackIndex;
@property (nonatomic, strong) NSMutableDictionary *matchedTracks;

@end


SpecBegin(GameManager)

describe(@"GameManager", ^{
    __block NSArray *testTracks;
    __block id mockDelegate;
    __block GameManager *gameManager;
    
    beforeAll(^{
        [Expecta setAsynchronousTestTimeout:5];
    });
    
    beforeEach(^{
        mockDelegate = OCMProtocolMock(@protocol(GameManagerDelegate));
        gameManager = [[GameManager alloc] init];
        
        gameManager.currentGame = [[Game alloc] init];
        gameManager.matchedTracks = [NSMutableDictionary new];
        gameManager.selectedTrackIndex = -1;
        gameManager.delegate = mockDelegate;
        Track *track1 =  [MTLJSONAdapter modelOfClass:Track.class fromJSONDictionary:@{@"id" : @123, @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"} error:nil];
        Track *track2 = [MTLJSONAdapter modelOfClass:Track.class fromJSONDictionary:@{@"id" : @215, @"artwork_url" : @"https://i1.sndcdn.com/artworks-0001657432-b1vhfv-large.jpg"} error:nil];

        testTracks = @[track1, track2, [track1 copy], [track2 copy]];
        gameManager.currentGame.tracks = testTracks;
        
    });
    
    describe(@"startGame", ^{
        it(@"calls the track service and wait for the tracklist to initialize the game", ^{
            waitUntil(^(DoneCallback done) {
                [gameManager startGameWithCompletionHandler:^(NSArray *tracks, NSError *error) {
                    expect(tracks).notTo.beNil;
                    expect(tracks.count).to.beGreaterThan(0);
                    expect(gameManager.currentGame.tracks.count).to.beGreaterThan(0);
                    done();
                }];
            });
            
        });
    });
    
    describe(@"isTrackAlreadySelected", ^ {
       it(@"should check the matched tracks dictionary to check if the track is already selected", ^{
           [gameManager.matchedTracks setObject:@1 forKey:@0];
           expect([gameManager isTrackAlreadySelected:0]).to.equal(YES);
           expect([gameManager isTrackAlreadySelected:1]).to.equal(NO);

       });
        it(@"should check the selected track index to check if the track is already selected", ^{
            gameManager.selectedTrackIndex = 2;
            expect([gameManager isTrackAlreadySelected:2]).to.equal(YES);
        });
    });
    
    describe(@"selectItemAtIndex", ^{
        context(@"is the first item to be selected", ^{
            beforeEach(^{
                [gameManager selectTrackAtIndex:1];
            });
            it(@"sets the selected track index correctly", ^{
                expect(gameManager.selectedTrackIndex).to.equal(1);
            });
        });
        
        context(@"is the second track to be selected which matches the previous track", ^{
            beforeEach(^{
                gameManager.selectedTrackIndex = 2;
                OCMExpect([mockDelegate gameManager:gameManager didFoundMatchAtIndex:0 withIndex:2]);
                [gameManager selectTrackAtIndex:0];
            });

            it(@"sets the selectedIndex to -1", ^{
                expect(gameManager.selectedTrackIndex).to.equal(-1);
            });
            it(@"adds the first track index to the matchedTracks dictionary", ^{
                expect([gameManager.matchedTracks objectForKey:@(2)]).toNot.beNil();
            });
            it(@"adds the second track index to the matches dictionary", ^{
                expect([gameManager.matchedTracks objectForKey:@(0)]).toNot.beNil();
            });
            it(@"calls the didFoundMatch delegate method", ^{
                OCMVerifyAll(mockDelegate);
            });
        });
        
        context(@"is the second track to be selected which does not match with the previous track", ^{
            beforeEach(^{
                gameManager.selectedTrackIndex = 2;
                OCMExpect([mockDelegate gameManager:gameManager didNotFindMatchAtIndex:1 withIndex:2]);
                [gameManager selectTrackAtIndex:1];

            });
            it(@"sets the selectedIndex to -1", ^{
                expect(gameManager.selectedTrackIndex).to.equal(-1);
            });

            it(@"doesn't adds the first track index to the matchedTracks dictionary", ^{
                expect([gameManager.matchedTracks objectForKey:@(2)]).to.beNil();
            });
            it(@"doesn't the second track index to the matches dictionary", ^{
                expect([gameManager.matchedTracks objectForKey:@(0)]).to.beNil();
            });
            it(@"calls the didNotFindMatch delegate method", ^{
                OCMVerifyAll(mockDelegate);
            });

        });

        context(@"is the last track to be selected with a match which will end the game", ^{
            beforeEach(^{
                OCMExpect([mockDelegate didEndGame]);
                [gameManager selectTrackAtIndex:0];
                [gameManager selectTrackAtIndex:2];
                [gameManager selectTrackAtIndex:1];
                [gameManager selectTrackAtIndex:3];
            });
            it(@"calls the diEndGame delegate method", ^{
                OCMVerifyAll(mockDelegate);
            });
        });

    });
    
    describe(@"restartGame", ^{
        beforeEach(^{
            gameManager.selectedTrackIndex = 2;
            [gameManager selectTrackAtIndex:1];
            [gameManager restartGame];
        });

        it(@"restarts the game and brings its properties to the initial state", ^{
            expect(gameManager.selectedTrackIndex).to.equal(-1);
            expect(gameManager.matchedTracks.allKeys.count).to.equal(0);
        });
    });
    
    afterEach(^{
        mockDelegate = nil;
        gameManager = nil;
        testTracks = nil;
    });
    
    afterAll(^{
        
    });
    
});

SpecEnd


