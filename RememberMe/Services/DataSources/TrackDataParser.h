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

- (RACSignal *)parseResponse:(NSArray *)response;

@end
