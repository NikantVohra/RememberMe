//
//  GameManager.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "GameManager.h"
#import "TrackDataParser.h"
#import "Track.h"
#import "NSArray+Shuffle.h"
#import "Constants.h"

@interface GameManager()

@property (nonatomic) NSInteger selectedTrackIndex;
@property (nonatomic) NSMutableDictionary *matchedTracks;

@end


@implementation GameManager


- (RACSignal *)startMemoryGame {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        TrackDataParser *parser = [[TrackDataParser alloc] init];
        TrackService *service = [[TrackService alloc] init];
        [[[service fetchTrackList] flattenMap:^RACStream *(id json) {
            return [parser parseResponse:json];
        }]
         subscribeNext:^(NSArray *tracks) {
             self.currentGame = [[Game alloc] initWithTracks:tracks];
             self.matchedTracks = [[NSMutableDictionary alloc] init];
             self.selectedTrackIndex = -1;
             [subscriber sendNext:self.currentGame.tracks];
         } error:^(NSError *error) {
             [subscriber sendError:error];
         }];
        return nil;
    }];
    return signal;

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
    return [self.matchedTracks objectForKey:@(index)] != nil || self.selectedTrackIndex == index;
}

- (void)restartGame {
    self.selectedTrackIndex = -1;
    self.matchedTracks = [NSMutableDictionary new];
    self.currentGame.tracks =  [self.currentGame.tracks shuffle];
}



@end
