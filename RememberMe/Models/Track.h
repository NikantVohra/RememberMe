//
//  Track.h
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Track : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSNumber *trackId;
@property (nonatomic, strong, readonly) NSString *artworkUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error;

@end
