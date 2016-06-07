//
//  GameManager.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "GameManager.h"
#import "TrackDataManager.h"
#import "Track.h"
#import "NSArray+Shuffle.h"
#import "Constants.h"

@interface GameManager()

@property (nonatomic) NSInteger selectedTrackIndex;
@property (nonatomic) NSMutableDictionary *matchedTracks;

@end


@implementation GameManager



- (void)startGameWithCompletionHandler:(void (^)(NSArray *tracks, NSError *error))completion {
    TrackDataManager *dataManager = [[TrackDataManager alloc] init];
    [dataManager getTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            if(tracks.count < maxTracks) {
                completion(nil, error);
            }
            else {
                self.currentGame = [[Game alloc] initWithTracks:tracks];
                self.matchedTracks = [[NSMutableDictionary alloc] init];
                self.selectedTrackIndex = -1;
                completion(self.currentGame.tracks, nil);
            }
        }
        else {
            completion(nil, error);
        }
    }];
}

- (void)selectTrackAtIndex:(NSInteger)index
{
    if (index >= self.currentGame.tracks.count || [self isTrackAlreadySelected:index]) {
        return;
    }
    
    Track *currentTrack = self.currentGame.tracks[index];
    
    if (self.selectedTrackIndex > -1 && index != self.selectedTrackIndex) {
        Track *selectedTrack = self.currentGame.tracks[self.selectedTrackIndex];
        if ([selectedTrack.trackId isEqualToNumber:currentTrack.trackId]) {
            [self.delegate gameManager:self didFoundMatchAtIndex:index withIndex:self.selectedTrackIndex];
            [self.matchedTracks setObject:@1 forKey:@(index)];
            [self.matchedTracks setObject:@1 forKey:@(self.selectedTrackIndex)];
            if (self.matchedTracks.allKeys.count == self.currentGame.tracks.count) {
                [self.delegate didEndGame];
            }
        }
        else {
            [self.delegate gameManager:self didNotFindMatchAtIndex:index withIndex:self.selectedTrackIndex];
        }
        self.selectedTrackIndex = -1;
    }
    else {
        self.selectedTrackIndex = index;
    }
    return;
}

- (BOOL)isTrackAlreadySelected:(NSUInteger)index {
    return [self.matchedTracks objectForKey:@(index)] != nil;
}

- (void)restartGame {
    self.selectedTrackIndex = -1;
    self.matchedTracks = [NSMutableDictionary new];
    [self.currentGame.tracks shuffle];
}



@end
