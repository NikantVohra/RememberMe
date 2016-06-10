//
//  TrackDataManager.h
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TrackDataParser : NSObject

/**
 *  Parses the json response and returns a RAC signal which can be subscribed to get the track list
 *
 *  @param response : response array fetched from service
 *
 *  returns RAC signal that maps the response to track object
 */

- (RACSignal *)parseResponse:(NSArray *)response;

@end
