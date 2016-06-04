//
//  Track.h
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject<NSCopying>

@property (nonatomic, strong) NSNumber *trackId;
@property (nonatomic, strong) NSString *artworkUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
