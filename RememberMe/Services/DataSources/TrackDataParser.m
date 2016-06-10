//
//  TrackDataParser.m
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import "TrackDataParser.h"
#import "TrackService.h"
#import "Track.h"

@interface TrackDataParser()


@end

@implementation TrackDataParser

- (RACSignal *)parseResponse:(NSArray *)response {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error = nil;
        NSMutableArray *tracks = [[NSMutableArray alloc] init];
        for(NSDictionary *trackDict in response) {
            NSString *artworkUrl = trackDict[@"artwork_url"];
            if(![artworkUrl isKindOfClass:[NSNull class]]) {
                Track* track = [MTLJSONAdapter modelOfClass:[Track class]
                                fromJSONDictionary:trackDict
                                             error:&error];
                [tracks addObject:track];
            }
        }
        if(error) {
            [subscriber sendError:error];
        }
        else {
            [subscriber sendNext:tracks];
        }
        [subscriber sendCompleted];
        return nil;
    }];
}



@end
