//
//  Game.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "Game.h"
#import "NSArray+Shuffle.h"
#import "Track.h"
#import "Constants.h"

@implementation Game

- (id)initWithTracks:(NSArray *)tracks {
    if(self = [super init]) {
        NSArray *filteredTracks = [tracks subarrayWithRange:NSMakeRange(0, maxTracks)];
        NSMutableArray *trackList = [[NSMutableArray alloc] init];
        for(Track *track in filteredTracks) {
            [trackList addObject:track];
            [trackList addObject:[track copy]];
        }
        self.tracks = [trackList shuffle];
    }
    return self;
}

@end
