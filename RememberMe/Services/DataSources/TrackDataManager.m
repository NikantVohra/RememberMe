//
//  TrackDataManager.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "TrackDataManager.h"
#import "TrackService.h"
#import "Track.h"

@interface TrackDataManager()

@property (nonatomic, strong) TrackService *trackService;
@property (nonatomic, strong) NSMutableDictionary *trackAtworkUrlCache;

@end

@implementation TrackDataManager

- (id)init {
    if(self = [super init]) {
        self.trackService = [[TrackService alloc] init];
        self.trackAtworkUrlCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)getTrackListWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))completion {
    [self.trackService fetchTrackListWithCompletionHandler:^(NSArray *response, NSError *error) {
        if(!error) {
            NSMutableArray *tracks = [[NSMutableArray alloc] init];
            for(NSDictionary *trackDict in response) {
                NSString *artworkUrl = trackDict[@"artwork_url"];
                if(![artworkUrl isKindOfClass:[NSNull class]] && ![self isTrackArtworkAlreadyPresent:artworkUrl]) {
                    Track *track = [[Track alloc] initWithDictionary:trackDict];
                    [self.trackAtworkUrlCache setObject:@1 forKey:track.artworkUrl];
                    [tracks addObject:track];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(tracks, nil);
            });

        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });

        }
    }];
}

- (BOOL)isTrackArtworkAlreadyPresent:(NSString *)artworkUrl {
    return [self.trackAtworkUrlCache objectForKey:artworkUrl];
}

@end
