//
//  GameManager.h
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "TrackService.h"


@class GameManager;

@protocol GameManagerDelegate <NSObject>

/**
 *  Called on the delegate when a match is found at an index with the previous index
 */
- (void)gameManager:(GameManager *)manager didFoundMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex;

/**
 *  Called on the delegate when the track at the current index does not match the previous index
 */
- (void)gameManager:(GameManager *)manager didNotFindMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex;

/**
 *  Called on the delegate the game is finished
 */
- (void)didEndGame;

@end

@interface GameManager : NSObject

@property (nonatomic, weak) id<GameManagerDelegate> delegate;
@property (nonatomic, strong) Game *currentGame;

/**
 *  Fetches the tracklist, parses it in a tracklist which is used to initialize the current game
 *
 *  returns a RAC signal which can be subscribed to get the track list
 */

- (RACSignal *)startMemoryGame;

- (void)selectTrackAtIndex:(NSInteger)index;

- (void)restartGame;

- (BOOL)isTrackAlreadySelected:(NSUInteger)index;

@end
