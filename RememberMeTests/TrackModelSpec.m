//
//  TrackModelTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Track.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(Track)

describe(@"Track", ^{
    __block Track *track;
    __block NSDictionary *trackDictionary;
    
    beforeAll(^{
        
    });
    
    beforeEach(^{
        trackDictionary = @{@"id" : @267291077, @"artwork_url" : @"https://i1.sndcdn.com/artworks-000165707152-b1vhfv-large.jpg"};;
        track = [[Track alloc] initWithDictionary:trackDictionary];
    });
    
    describe(@"designated initializer", ^{
        it(@"sets all properties to correct values from the dictionary", ^{
            expect(track.trackId).to.equal(trackDictionary[@"id"]);
            expect(track.artworkUrl).to.equal(trackDictionary[@"artwork_url"]);
        });
    });
    
    afterEach(^{
        trackDictionary = nil;
        track = nil;
    });
    
    afterAll(^{
        
    });

});

SpecEnd