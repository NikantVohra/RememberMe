//
//  HomeViewControllerTests.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/7/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "HomeViewController.h"
#import <OCMOCK/OCMock.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "GameManager.h"

@interface HomeViewController()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GameManager *gameManager;

- (void)startGame;
- (void)displayError:(NSString *)message;
- (void)displayGameFinishedAlert;

@end

SpecBegin(HomeViewController)

    __block HomeViewController *_vc;
    beforeAll(^{
        
    });

    beforeEach(^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"HomeViewNavigationController"];
        _vc = (HomeViewController *)[nav visibleViewController];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        UIView *view = _vc.view;
        expect(view).toNot.beNil();
    });

    describe(@"HomeViewController Initialization", ^{
        
        it(@"should be instantiated from the storyboard", ^{
            expect(_vc).toNot.beNil();
            expect(_vc).to.beInstanceOf([HomeViewController class]);
        });
        
        it(@"should have an outlet for the collection view", ^{
            expect(_vc.collectionView).toNot.beNil();
        });
        
    });

    describe(@"StartGame", ^{
        it(@"should call start game method on GameManager", ^{
            id gameManager = OCMClassMock([GameManager class]);
            _vc.gameManager = gameManager;
            [[gameManager expect] startGameWithCompletionHandler:[OCMArg any]];
            [_vc startGame];
            OCMVerifyAll(gameManager);
        });
    });

    describe(@"displayError", ^{
        it(@"displays the alert controller with the provided message", ^{
            [_vc displayGameFinishedAlert];
            expect(_vc.presentedViewController).to.beKindOf([UIAlertController class]);
        });
    });

    describe(@"displayGameFinishedAlert", ^{
        it(@"displays the alert controller with the game finished message", ^{
            [_vc displayError:@"Please check your connection"];
            expect(_vc.presentedViewController).to.beKindOf([UIAlertController class]);
        });
    });

    afterAll(^{
    });



SpecEnd


