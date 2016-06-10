//
//  Track.m
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import "Track.h"

@implementation Track 

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"trackId": @"id",
             @"artworkUrl": @"artwork_url"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    return self;
}


@end
