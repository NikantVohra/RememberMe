//
//  TrackService.h
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TrackService : NSObject


/**
 *  Fetches the track list from the service and returns a RAC signal which can be subscribed to get the response
 *  returns RAC signal that executes the request to fetch the tracks from sounclodu service
 */

- (RACSignal *)fetchTrackList;

@end