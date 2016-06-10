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
#import "Constants.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ArrayDataSource.h"
#import "AFNetworkReachabilityManager.h"



static NSString * const TrackCellIdentifier = @"TrackCollectionViewCell";
static const int CellsPerRow = maxTracks / 2;
static const float CellPadding = 5.0;


@interface HomeViewController()<UICollectionViewDelegate, GameManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *trackList;
@property (nonatomic, strong) GameManager *gameManager;
@property (nonatomic, strong) ArrayDataSource *tracksArrayDataSource;
@property (nonatomic) BOOL hasGameStarted;

@end

@implementation HomeViewController


#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.trackList = [[NSMutableArray alloc] init];
    self.collectionView.delegate = self;
    self.hasGameStarted = NO;
    [self checkNetworkAvailability];
    self.gameManager = [[GameManager alloc] init];
    self.gameManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Handle Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView DataSource

- (void)configureCollectionViewDatasource {
    CollectionViewCellCellConfigureBlock configureCell = ^(TrackCollectionViewCell *cell, Track *track) {
        [cell configureWithTrack:track];
    };
    NSArray *tracks = self.trackList;
    self.tracksArrayDataSource = [[ArrayDataSource alloc] initWithItems:tracks
                                                         cellIdentifier:TrackCellIdentifier
                                                     configureCellBlock:configureCell];
    self.collectionView.dataSource = self.tracksArrayDataSource;
}

#pragma mark - UICollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (collectionView.frame.size.width / (CellsPerRow + 1)) - CellPadding;
    CGFloat cellHeight = (collectionView.frame.size.height / (CellsPerRow + 1)) - CellPadding;
    return CGSizeMake(cellWidth, cellHeight);
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
    [self displayGameFinishedAlert];
}


#pragma mark - Game Helper Methods

- (void)startGame {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Preparing Game", nil)];
    [[[self.gameManager startMemoryGame] deliverOn:[RACScheduler mainThreadScheduler]]
        subscribeNext:^(NSArray *tracks) {
        [SVProgressHUD dismiss];
        self.hasGameStarted = YES;
        [self.trackList removeAllObjects];
        [self.trackList addObjectsFromArray:tracks];
        [self configureCollectionViewDatasource];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self displayError:@"Some problem occured while preparing the game. Please try later."];
    }];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self resetGame];
}

- (void)resetGame {
    [self resetCells];
    [self.gameManager restartGame];
    [self.trackList removeAllObjects];
    [self.trackList addObjectsFromArray:[[self.gameManager currentGame] tracks]];
    [self configureCollectionViewDatasource];
    [self.collectionView reloadData];
}


- (void)resetCells {
    for (int i = 0; i < self.trackList.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        TrackCollectionViewCell *cell = (TrackCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell flipToSide:NO];
    }
}


- (void)displayGameFinishedAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Awesome", nil)
        message:NSLocalizedString(@"You won the game. Play Again.", nil)
        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self resetGame];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Network Handling

- (void)checkNetworkAvailability {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if(![self hasGameStarted]) {
                    [self startGame];
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                if(![self hasGameStarted]) {
                    [self displayError:@"Please check your internet connection and try again."];
                }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - Error Handling

- (void)displayError:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                             message:NSLocalizedString(message, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
