//
//  TrackDataManagerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackDataParser.h"
#import "Track.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(TrackDataParser)

    __block TrackDataParser *trackParser;
    __block NSArray *json;

    beforeAll(^{
        [Expecta setAsynchronousTestTimeout:5];
        
    });

    beforeEach(^{
        trackParser = [TrackDataParser new];
        json = @[@{@"id" : @267291077, @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"}, @{@"id" : @267291078, @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"}];
    });


    describe(@"TrackDataManager", ^{
        it(@"gets the tracklist of user from the service and parses it to form an array of tracks", ^{
            waitUntil(^(DoneCallback done) {
                [[trackParser parseResponse:json] subscribeNext:^(NSArray *tracks) {
                    expect(tracks).toNot.beNil();
                    expect(tracks).to.beKindOf([NSArray class]);
                    expect(tracks.count).to.beGreaterThan(0);
                    expect(tracks[0]).to.beKindOf([Track class]);
                    done();
                }
                error:^(NSError *error) {
                     expect(error).to.beNil();
                     done();
                }];
                
            });
        });
    });



    afterEach(^{
        trackParser = nil;
        json = nil;
    });

    afterAll(^{
        
    });


SpecEnd

