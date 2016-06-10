//
//  TrackServiceTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackService.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>


SpecBegin(TrackService)

    __block TrackService *trackService;

    beforeAll(^{
        [Expecta setAsynchronousTestTimeout:5];
        
    });

    beforeEach(^{
        trackService = [TrackService new];
    });


    describe(@"Track Service", ^{
        it(@"fetches the tracklist of user from soundcloud API and returns it as Array", ^{
            waitUntil(^(DoneCallback done) {
                [[trackService fetchTrackList] subscribeNext:^(NSArray *tracks) {
                    expect(tracks).toNot.beNil();
                    expect(tracks).to.beKindOf([NSArray class]);
                    expect(tracks.count).to.beGreaterThan(0);
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
        trackService = nil;
    });

    afterAll(^{
        
    });


SpecEnd


