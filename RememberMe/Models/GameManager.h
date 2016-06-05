//
//  GameManager.h
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameManager;

@protocol GameManagerDelegate <NSObject>

- (void)gameManager:(GameManager *)manager didFoundMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex;
- (void)gameManager:(GameManager *)manager didNotFindMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex;
- (void)didEndGame;

@end

@interface GameManager : NSObject

@property (nonatomic, weak) id<GameManagerDelegate> delegate;

- (void)startGameWithCompletionHandler:(void (^)(NSArray *tracks, NSError *error))completion;

- (void)selectTrackAtIndex:(NSInteger)index;

- (void)restartGame;

- (BOOL)isTrackAlreadySelected:(NSUInteger)index;

@end
