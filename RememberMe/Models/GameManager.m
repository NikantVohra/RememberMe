//
//  GameManager.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "GameManager.h"
#import "Game.h"
#import "TrackDataManager.h"

@interface GameManager()

@property (nonatomic, strong) Game *currentGame;
@property (nonatomic) NSInteger selectedTrackIndex;
@property (nonatomic) NSInteger mismatchedTracks;

@end


@implementation GameManager

static const int maxTracks = 8;


- (void)startGameWithCompletionHandler:(void (^)(NSArray *tracks, NSError *error))completion {
    TrackDataManager *dataManager = [[TrackDataManager alloc] init];
    [dataManager getTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            if(tracks.count < maxTracks) {
                completion(nil, error);
            }
            else {
                self.currentGame = [[Game alloc] initWithTracks:tracks];
                completion(self.currentGame.tracks, nil);
            }
        }
        else {
            completion(nil, error);
        }
    }];
}


@end
