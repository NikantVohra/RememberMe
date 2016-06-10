//
//  TrackCollectionViewCell.m
//  RememberMe
//
//  Created by anon on 6/4/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import "TrackCollectionViewCell.h"

@interface TrackCollectionViewCell()

@property (nonatomic) BOOL isFlipping;
@property (nonatomic) BOOL flipped;

@end

@implementation TrackCollectionViewCell

- (void)configureWithTrack:(Track *)track {
    [self.artworkImageView sd_setImageWithURL:[NSURL URLWithString:track.artworkUrl] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
    self.flipped = NO;
}


- (void)flip {
    [self flipToSide:!self.flipped];
}

- (void)showBackSide {
    [self flipToSide:NO];
}


- (void)showFrontSide {
    [self flipToSide:YES];
}


- (void)flipToSide:(BOOL)front {
    if(self.isFlipping) {
        return;
    }
    self.isFlipping = YES;
    [UIView transitionWithView:self.contentView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        if(!front) {
            [self.contentView insertSubview:self.backgroundImageView aboveSubview:self.artworkImageView];
        }
        else {
            [self.contentView insertSubview:self.artworkImageView aboveSubview:self.backgroundImageView];
        }
    } completion:^(BOOL finished) {
        self.flipped = front;
        self.isFlipping = NO;
    }];
}




@end
