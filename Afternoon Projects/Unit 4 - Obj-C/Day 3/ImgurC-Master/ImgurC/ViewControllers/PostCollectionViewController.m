//
//  PostCollectionViewController.m
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "PostCollectionViewController.h"

@interface PostCollectionViewController ()

@end

@implementation PostCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

// MARK: - ViewLifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    [[self navigationItem] setHidesSearchBarWhenScrolling:NO];
    [[self navigationItem] setSearchController:searchController];
}

// MARK: - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor blueColor]];
    return cell;
}
@end
