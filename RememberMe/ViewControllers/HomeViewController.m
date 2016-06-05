//
//  HomeViewController.m
//  RememberMe
//
//  Created by Vohra, Nikant on 6/4/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

#import "HomeViewController.h"
#import "TrackCollectionViewCell.h"
#import "TrackCollectionViewCell.h"
#import "Track.h"
#import "GameManager.h"


@interface HomeViewController()<UICollectionViewDataSource, UICollectionViewDelegate, GameManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *trackList;
@property (nonatomic, strong) GameManager *gameManager;
@end

@implementation HomeViewController

static const int CellsPerRow = 4;
static const float CellPadding = 5.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.trackList = [[NSMutableArray alloc] init];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self startGame];
    
}

- (void)didReceiveMemoryWarning {
    
}

- (void)startGame {
    self.gameManager = [[GameManager alloc] init];
    self.gameManager.delegate = self;
    [self.gameManager startGameWithCompletionHandler:^(NSArray *tracks, NSError *error) {
        [self.trackList addObjectsFromArray:tracks];
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.trackList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TrackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TrackCollectionViewCell" forIndexPath:indexPath];
    Track *track = [self.trackList objectAtIndex:indexPath.row];
    [cell configureWithTrack:track];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TrackCollectionViewCell *cell = (TrackCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(![self.gameManager isTrackAlreadySelected:indexPath.row]) {
        [cell flip];
        [self.gameManager selectTrackAtIndex:indexPath.row];
    }
}


#pragma mark - GameManager Delegate

- (void)gameManager:(GameManager *)manager didFoundMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex {
    
}

- (void)gameManager:(GameManager *)manager didNotFindMatchAtIndex:(NSInteger)firstindex withIndex:(NSInteger)secondIndex {
    TrackCollectionViewCell *firstCell = (TrackCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstindex inSection:0]];
    TrackCollectionViewCell *secondCell = (TrackCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
    [firstCell performSelector:@selector(flip) withObject:nil afterDelay:0.5];
    [secondCell performSelector:@selector(flip) withObject:nil afterDelay:0.5];
}


- (void)didEndGame {
    
}
@end
