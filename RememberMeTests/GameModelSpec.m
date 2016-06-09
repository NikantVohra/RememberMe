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
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(Game)

    describe(@"Game", ^{
        __block Game *game;
        __block NSArray *tracks;
        
        beforeAll(^{
            
        });
        
        beforeEach(^{
            NSMutableArray *tracksArray = [NSMutableArray new];
            NSError *error = nil;
            for (int i=0; i < maxTracks; i++) {
                Track *newTrack = [MTLJSONAdapter modelOfClass:Track.class fromJSONDictionary:@{@"id":@(i)} error:&error];
                [tracksArray addObject:newTrack];
            }
            tracks = tracksArray;
            game = [[Game alloc] initWithTracks:tracks];
        });
        
        describe(@"designated initializer", ^{
            it(@"initializes the game and makes copy of the input tracks", ^{
                expect(game.tracks).toNot.beNil();
                expect(game.tracks.count).to.equal(tracks.count * 2);
            });
        });
        
        afterEach(^{
            game = nil;
            tracks = nil;
        });
        
        afterAll(^{
            
        });
        
    });

SpecEnd


