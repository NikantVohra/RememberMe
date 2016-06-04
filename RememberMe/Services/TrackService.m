//
//  TrackService.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//
#import "TrackService.h"
#import "Constants.h"

@interface TrackService()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@end

@implementation TrackService

- (id)init {
    if(self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

- (void)fetchTrackListWithCompletionHandler:(void(^)(NSArray *response, NSError *error))completion {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@", soundCloudApiUrl, clientId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            completion(responseObject, nil);
        } else {
            completion(nil, error);
        }
    }];
    [dataTask resume];
    
}



@end
