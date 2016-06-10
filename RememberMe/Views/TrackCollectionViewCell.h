//
//  TrackCollectionViewCell.h
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TrackCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (void)configureWithTrack:(Track *)track;
- (void)flip;
- (void)flipToSide:(BOOL)front;

@end
