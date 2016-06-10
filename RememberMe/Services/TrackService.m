//
//  TrackService.m
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
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


- (RACSignal *)fetchTrackList {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@", soundCloudApiUrl, clientId]];

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self fetchTrackListFromURL:URL WithCompletionHandler:^(NSArray *response, NSError *error) {
            if(!error) {
                [subscriber sendNext:response];
            }
            else {
                [subscriber sendError:error];
            }
            [subscriber sendCompleted];

        }];
        return nil;
        
    }];
}

- (void)fetchTrackListFromURL:(NSURL *)url WithCompletionHandler:(void(^)(NSArray *response, NSError *error))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
