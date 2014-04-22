//
//  MURPlaceViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/22/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURPlaceViewController.h"

@implementation MURPlaceViewController

- (instancetype)initWithPlace:(MURPlace *)given {
	self = [super init];
	
	_place = given;
	self.title = _place.name;
	self.view.backgroundColor = [MURTheme backgroundColor];
	
	CGRect collectionFrame = self.view.bounds;
	collectionFrame.size.height /= 2.0;
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.scrollDirection = UICollectionViewScrollDirectionVertical;
	
	_collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
	[_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"PlaceCell"];
	_collectionView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
	_collectionView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	[self.view addSubview:_collectionView];

	return self;
}

- (instancetype)init {
	NSLog(@"SHOULDN'T BE INITTING WITH DEFAULT CONSTRUCTOR!");
	return ((self = [self initWithPlace:[[MURPlace alloc] initWithName:@"Connections"]]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UILabel *legend = [[UILabel alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 50.0, self.view.frame.size.width, 50.0)];
	legend.textAlignment = NSTextAlignmentCenter;
	legend.font = [UIFont systemFontOfSize:13.0];
	legend.textColor = [UIColor lightGrayColor];
	legend.text = @"Vegan: *     Vegetarian: ☀︎     Gluten-free: ✝";
	[self.view addSubview:legend];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _place.dishes.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100.0, 100.0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(30.0, 32.5, 10.0, 32.5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];
	
	if (![cell viewWithTag:1]) {
		CGSize labelSize = CGSizeMake(cell.frame.size.width, 20.0);
		UIImageView *foodThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height - (labelSize.height + 5.0))];
		foodThumb.contentMode = UIViewContentModeScaleAspectFill;
		foodThumb.layer.masksToBounds = YES;
		foodThumb.layer.cornerRadius = 10.0;
		foodThumb.tag = 1;
	
		UILabel *foodCaption = [[UILabel alloc] initWithFrame:(CGRect){CGPointMake(0.0, foodThumb.frame.size.height), labelSize}];
		foodCaption.font = [UIFont fontWithName:@"Helvetica-Light" size:18.0];
		foodCaption.textAlignment = NSTextAlignmentCenter;
		foodCaption.textColor = [UIColor blackColor];
		foodCaption.adjustsFontSizeToFitWidth = YES;
		foodCaption.minimumScaleFactor = 0.25;
		foodCaption.tag = 2;
	
		[cell.contentView addSubview:foodThumb];
		[cell.contentView addSubview:foodCaption];
	}
	
	UIImageView *foodThumb = (UIImageView *)[cell.contentView viewWithTag:1];
	UILabel *foodCaption = (UILabel *)[cell.contentView viewWithTag:2];

	NSArray *dishComponents = [_place.dishes[indexPath.row] componentsSeparatedByString:@"; "];
	NSString *name = dishComponents[0];
	foodCaption.text = name;

	for (int i = 1; i < dishComponents.count; i++) {
		if ([dishComponents[i] rangeOfString:@"vin"].location != NSNotFound) {
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Vegan"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" *"];
			}
		}
		
		else if ([dishComponents[i] rangeOfString:@"v"].location != NSNotFound) {
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" ☀︎"];
			}
		}
		
		else if ([dishComponents[i] rangeOfString:@"gf"].location != NSNotFound) {
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Gluten"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" ✝"];
			}
		}
	}
	
	foodThumb.image = [UIImage imageNamed:name];

	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end
