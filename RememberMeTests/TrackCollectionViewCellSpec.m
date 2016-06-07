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
        
        describe(@"configure cell", ^{
            it(@"configures cell with the track and sets cell properties", ^{
                expect(cell.flipped).to.equal(NO);
                expect(cell.isFlipping).to.equal(NO);
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

//@interface TrackCollectionViewCellTests : XCTestCase
//
//
//
//@end
//
//@implementation TrackCollectionViewCellTests
//
//- (void)setUp {
//    [super setUp];
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    [super tearDown];
//}
//
//- (void)testCellConfigureMethod {
//    id mocktrack = OCMClassMock([Track class]);
//    TrackCollectionViewCell *cell = [[TrackCollectionViewCell alloc] init];
//    [cell configureWithTrack:mocktrack];
//    XCTAssertEqual(cell.flipped, NO);
//    XCTAssertEqual(cell.isFlipping, NO);
//}
//
//- (void)testFlipToSideMethod {
//    id mocktrack = OCMClassMock([Track class]);
//    TrackCollectionViewCell *cell = [[TrackCollectionViewCell alloc] init];
//    [cell configureWithTrack:mocktrack];
//    [cell flipToSide:YES];
//    XCTAssertEqual(cell.isFlipping, YES);
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
//    XCTAssertEqual(cell.isFlipping, NO);
//    XCTAssertEqual(cell.flipped, YES);
//}
//
//- (void)testFlipMethod {
//    id mocktrack = OCMClassMock([Track class]);
//    TrackCollectionViewCell *cell = [[TrackCollectionViewCell alloc] init];
//    [cell configureWithTrack:mocktrack];
//    cell.flipped = YES;
//    [cell flip];
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
//    XCTAssertEqual(cell.flipped, NO);
//
//}
//
//@end
