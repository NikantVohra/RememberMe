//
//  TrackDataManager.h
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackDataManager : NSObject

- (void)getTrackListWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))completion;

@end
