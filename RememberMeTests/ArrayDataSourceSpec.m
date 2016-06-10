//
//  ArrayDataSourceTests.m
//  RememberMe
//
//  Created by anon on 6/7/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArrayDataSource.h"
#import <OCMOCK/OCMock.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>




SpecBegin(ArrayDataSource)

describe(@"ArrayDataSource", ^{
    __block id mockCollectionView;
    __block ArrayDataSource *dataSource;

    beforeAll(^{
    });
    
    beforeEach(^{
        mockCollectionView = OCMClassMock([UICollectionView class]);
    });
    
    describe(@"designated initializer", ^{
        it(@"returns nil if initialized without items", ^{
            dataSource = [[ArrayDataSource alloc] init];
            expect(dataSource).to.beNil();
        });
        it(@"returns datasource if initialized with items", ^{
            dataSource = [[ArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"foo" configureCellBlock:^(UICollectionViewCell *a, id b){}];
            expect(dataSource).toNot.beNil();
        });
    });
    

    describe(@"number of items in section", ^{
        it(@"gets the number of items in the collection view", ^{
            dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:nil];
            NSUInteger items = [dataSource collectionView:mockCollectionView numberOfItemsInSection:0];
            expect(items).to.equal(2);
        });
    });
    
    describe(@"configure cell", ^{
        it(@"should configure the cell with items and conigure cell block", ^{
            __block UICollectionViewCell *configuredCell = nil;
            __block id configuredObject = nil;
            CollectionViewCellCellConfigureBlock block = ^(UICollectionViewCell *a, id b){
                configuredCell = a;
                configuredObject = b;
            };
            dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:block];
            UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
            [[[mockCollectionView expect] andReturn:cell] dequeueReusableCellWithReuseIdentifier:@"foo" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            __block id result = [dataSource collectionView:mockCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            expect(result).to.equal(cell);
            expect(configuredCell).to.equal(cell);
            expect(configuredObject).to.equal(@"a");
        });
        
    });
    
    afterEach(^{
        mockCollectionView = nil;
    });
    
    afterAll(^{
        
    });
    
});

SpecEnd


