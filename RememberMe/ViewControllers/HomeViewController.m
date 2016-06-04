//
//  HomeViewController.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "HomeViewController.h"
#import "TrackDataManager.h"
#import "TrackCollectionViewCell.h"
#import "TrackCollectionViewCell.h"
#import "Track.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface HomeViewController()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *trackList;
@property (nonatomic, strong) TrackDataManager *dataManager;
@end

@implementation HomeViewController

static const int CellsPerRow = 4;
static const float CellPadding = 5.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.trackList = [[NSMutableArray alloc] init];
    self.dataManager = [[TrackDataManager alloc] init];
    [self.dataManager getTrackListWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        if(!error) {
            [self.trackList addObjectsFromArray:tracks];
            [self.collectionView reloadData];
        }
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.trackList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TrackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TrackCollectionViewCell" forIndexPath:indexPath];
    Track *track = [self.trackList objectAtIndex:indexPath.row];
    [cell.artworkImageView sd_setImageWithURL:[NSURL URLWithString:track.artworkUrl] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
    return cell;
}


#pragma mark - UICollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (collectionView.frame.size.width / (CellsPerRow + 1)) - CellPadding;
    return CGSizeMake(cellWidth, cellWidth);
;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

}


@end
