//
//  TrackService.h
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface TrackService : NSObject

-(void)fetchTrackListWithCompletionHandler:(void(^)(NSArray *response, NSError *error))completion;

@end