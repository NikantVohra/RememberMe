//
//  Track.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "Track.h"

@implementation Track

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if(self = [super init]) {
        self.trackId = [dictionary objectForKey:@"id"];
        self.artworkUrl = [dictionary objectForKey:@"artwork_url"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    Track *copy = [[[self class] allocWithZone: zone] init];
    [copy setTrackId:self.trackId];
    [copy setArtworkUrl:self.artworkUrl];
    return copy;
}
@end
