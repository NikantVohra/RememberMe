//
//  Game.h
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSArray *tracks;

- (instancetype)initWithTracks:(NSArray *)tracks;


@end
