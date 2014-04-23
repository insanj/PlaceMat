//
//  MURPlaceViewController.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/22/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURTableViewController.h"
#import "MURPlace.h"

@interface MURPlaceViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain) MURPlace *place;
@property(nonatomic, retain) UICollectionView *collectionView;

- (instancetype)initWithPlace:(MURPlace *)given;

@end

