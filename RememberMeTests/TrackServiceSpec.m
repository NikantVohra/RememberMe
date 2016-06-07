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


    describe(@"service", ^{
        it(@"fetches the tracklist of user from soundcloud API and returns it as Array", ^{
            waitUntil(^(DoneCallback done) {
                
                [trackService fetchTrackListWithCompletionHandler:^(NSArray *response, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        expect(response).toNot.beNil();
                        expect(response).to.beKindOf([NSArray class]);
                        expect(response.count).to.beGreaterThan(0);
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


