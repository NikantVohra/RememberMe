//
//  TrackCollectionViewCellTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/7/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackCollectionViewCell.h"
#import <OCMock/OCMock.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>


@interface TrackCollectionViewCell()

@property(nonatomic) BOOL isFlipping;
@property(nonatomic) BOOL flipped;

@end

SpecBegin(TrackCollectionViewCell)

    describe(@"TrackCollectionViewCell", ^{
        __block id mockTrack;
        __block TrackCollectionViewCell *cell;
        
        beforeAll(^{
            
        });
        
        beforeEach(^{
            mockTrack = OCMClassMock([Track class]);
            cell = [[TrackCollectionViewCell alloc] init];
            [cell configureWithTrack:mockTrack];
        });
        
        describe(@"configure", ^{
            it(@"configures the cell with the track and sets cell properties", ^{
                expect(cell.flipped).to.equal(NO);
                expect(cell.isFlipping).to.equal(NO);
            });
        });
        
        describe(@"flip to", ^{
            context(@"front side", ^ {
                beforeEach(^{
                    [cell flipToSide:YES];
                });
                it(@"sets the flipped property on the cell to Yes", ^{
                    expect(cell.isFlipping).to.beTruthy();
                    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
                    expect(cell.flipped).to.beTruthy();
                });
            });
            context(@"back side", ^ {
                beforeEach(^{
                    [cell flipToSide:NO];
                });
                it(@"sets the flipped property on the cell to NO", ^{
                    expect(cell.isFlipping).to.beTruthy();
                    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
                    expect(cell.flipped).to.beFalsy();
                });
            });

        });
        
        describe(@"flip", ^{
            beforeEach(^{
                cell.flipped = NO;
                [cell flip];
            });
            it(@"flips the cell and switches the flipped property of the cell", ^{
                expect(cell.isFlipping).to.beTruthy;
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
                expect(cell.flipped).to.beTruthy();
            });
            
        });
        
        afterEach(^{
            mockTrack = nil;
            cell = nil;
        });
        
        afterAll(^{
            
        });
        
    });

SpecEnd


