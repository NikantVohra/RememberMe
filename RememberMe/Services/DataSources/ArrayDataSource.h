//
//  ArrayDataSource.h
//  RememberMe
//
//  Created by anon on 6/7/16.
//  Copyright © 2016 anon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^CollectionViewCellCellConfigureBlock)(id cell, id item);


@interface ArrayDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CollectionViewCellCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
