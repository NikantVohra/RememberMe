//
//  ArrayDataSourceTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/7/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArrayDataSource.h"
#import <OCMOCK/OCMock.h>

@interface ArrayDataSourceTests : XCTestCase

@end

@implementation ArrayDataSourceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitialization {
    XCTAssertNil([[ArrayDataSource alloc] init]);
    id obj1 = [[ArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"foo" configureCellBlock:^(UICollectionViewCell *a, id b){}];
    XCTAssertNotNil(obj1);
    
}

- (void)testNumberOfRows
{
    id mockCollectionView = OCMClassMock([UICollectionView class]);
    ArrayDataSource *dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:nil];
    XCTAssertEqual([dataSource collectionView:mockCollectionView numberOfItemsInSection:0], 2);
}


- (void)testCellConfiguration
{
    __block UICollectionViewCell *configuredCell = nil;
    __block id configuredObject = nil;
    CollectionViewCellCellConfigureBlock block = ^(UICollectionViewCell *a, id b){
        configuredCell = a;
        configuredObject = b;
    };
    ArrayDataSource *dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:block];
    
    id mockCollectionView = OCMClassMock([UICollectionView class]);
    
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    [[[mockCollectionView expect] andReturn:cell] dequeueReusableCellWithReuseIdentifier:@"foo" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    id result = [dataSource collectionView:mockCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertEqual(result, cell, @"Should return the dummy cell.");
    XCTAssertEqual(configuredCell, cell, @"This should have been passed to the block.");
    XCTAssertEqualObjects(configuredObject, @"a", @"This should have been passed to the block.");
}


@end
