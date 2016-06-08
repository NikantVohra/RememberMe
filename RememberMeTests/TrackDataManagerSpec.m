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
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(TrackDataManager)

    __block TrackDataManager *trackService;

    beforeAll(^{
        [Expecta setAsynchronousTestTimeout:5];
        
    });

    beforeEach(^{
        trackService = [TrackDataManager new];
    });


    describe(@"TrackDataManager", ^{
        it(@"gets the tracklist of user from the service and parses it to form an array of tracks", ^{
            waitUntil(^(DoneCallback done) {
                [trackService getTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        expect(tracks).toNot.beNil();
                        expect(tracks).to.beKindOf([NSArray class]);
                        expect(tracks.count).to.beGreaterThan(0);
                        expect(tracks[0]).to.beKindOf([Track class]);
                        expect(error).to.beNil();
                    });
                    done();
                }];
            });
        });
    });



    afterEach(^{
        trackService = nil;
    });

    afterAll(^{
        
    });


SpecEnd

