//
//  TrackCollectionViewCell.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "TrackCollectionViewCell.h"

@implementation TrackCollectionViewCell

- (void)configureWithTrack:(Track *)track {
    [self.artworkImageView sd_setImageWithURL:[NSURL URLWithString:track.artworkUrl] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];

}

@end
