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
	
	return self;
}

- (instancetype)init {
	NSLog(@" *** MURPlaceViewController shouldn't be initialized using the default constructor!");
	return ((self = [self initWithPlace:[[MURPlace alloc] initWithName:@"Connections"]]));
}

- (void)viewDidLoad {
	self.navigationItem.rightBarButtonItem = [[MURCheckinButtonItem alloc] initWithName:_place.name];
		
	//UIView *trueParent = _backingView; //self.navigationController.topViewController.view;// [UIApplication sharedApplication].keyWindow.rootViewController.view;
	CGRect collectionFrame = self.view.bounds;
	collectionFrame.size.height /= 1.75;
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.scrollDirection = UICollectionViewScrollDirectionVertical;
	
	_collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
	[_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"PlaceCell"];
	_collectionView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
	_collectionView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 20.0, 0.0);
	_collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0);
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	[self.view addSubview:_collectionView];
	
	CGRect backingFrame = self.view.bounds;
	backingFrame.origin.y += _collectionView.frame.origin.y + (self.view.bounds.size.height / 1.9);
	backingFrame.size.height = self.view.bounds.size.height - backingFrame.origin.y;
	
	_backingView = [[UIToolbar alloc] initWithFrame:backingFrame];
	[self.view insertSubview:_backingView aboveSubview:_collectionView];
	
	CGFloat side = fabs((self.view.bounds.size.height / 2.0) - (_collectionView.frame.size.height + 100.0));
	UIImageView *bigPlaceImage = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, self.view.frame.size.height - (side * 1.55), side, side)];
	bigPlaceImage.contentMode = UIViewContentModeScaleAspectFill;
	bigPlaceImage.layer.masksToBounds = YES;
	bigPlaceImage.layer.cornerRadius = 10.0;
	bigPlaceImage.image = _place.avatar;
	[self.view addSubview:bigPlaceImage];
	
	UILabel *bigPlaceText = [[UILabel alloc] initWithFrame:CGRectMake(bigPlaceImage.frame.origin.x + bigPlaceImage.frame.size.width + 10.0, bigPlaceImage.frame.origin.y, self.view.bounds.size.width - (20.0 + bigPlaceImage.frame.size.width + 20.0), bigPlaceImage.frame.size.height)];
	bigPlaceText.backgroundColor = [UIColor clearColor];
	bigPlaceText.textColor = [UIColor blackColor];
	bigPlaceText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
	bigPlaceText.text = [NSString stringWithFormat:@"Welcome to %@. You can use %@ to buy %@ during %@.", [_place.name stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]], _place.description, _place.serving, _place.time];
	bigPlaceText.numberOfLines = 0;
	bigPlaceText.minimumScaleFactor = 0.1;
	bigPlaceText.adjustsFontSizeToFitWidth = YES;
	[self.view addSubview:bigPlaceText]; // aboveSubview:_backingView];
	
	UILabel *legend = [[UILabel alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 50.0, self.view.frame.size.width, 50.0)];
	legend.textAlignment = NSTextAlignmentCenter;
	legend.font = [UIFont systemFontOfSize:13.0];
	legend.textColor = [UIColor lightGrayColor];
	legend.text = @"Vegan: *     Vegetarian: ✭     Gluten-free: ✝";
	[self.view addSubview:legend]; //aboveSubview:_backingView];
	
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
//	NSLog(@"%@", [[UIApplication sharedApplication].keyWindow.rootViewController.view recursiveDescription]);
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
			//if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Vegan"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" *"];
			//}
		}
		
		else if ([dishComponents[i] rangeOfString:@"v"].location != NSNotFound) {
			//if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" ✭"];
			//}
		}
		
		else if ([dishComponents[i] rangeOfString:@"gf"].location != NSNotFound) {
			//if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Gluten"]) {
				foodCaption.text = [foodCaption.text stringByAppendingString:@" ✝"];
			//}
		}
	}
	
	foodThumb.image = [UIImage imageNamed:name];

	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
		
	UIButton *giantNutrition = [[UIButton alloc] initWithFrame:[self collectionView:collectionView cellForItemAtIndexPath:indexPath].frame];
	[giantNutrition addTarget:self action:@selector(dismissGiantView:) forControlEvents:UIControlEventTouchUpInside];
	giantNutrition.backgroundColor = [UIColor clearColor];
	
	MURBlurView *blurBacking = [[MURBlurView alloc] initWithFrame:self.view.bounds inParentView:self.view];
	[blurBacking applyLightBlur];
		
	UIImageView *nutritionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nutrition"]];
	nutritionImage.contentMode = UIViewContentModeCenter;
	
	CGFloat motionRelativeValue = 10.0;
	UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	verticalMotionEffect.minimumRelativeValue = @(-motionRelativeValue);
	verticalMotionEffect.maximumRelativeValue = @(motionRelativeValue);
	
	UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	horizontalMotionEffect.minimumRelativeValue = @(-motionRelativeValue);
	horizontalMotionEffect.maximumRelativeValue = @(motionRelativeValue);
	
	UIMotionEffectGroup *group = [UIMotionEffectGroup new];
	group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
	[nutritionImage addMotionEffect:group];
	
	UILabel *nameCaption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, self.view.bounds.size.width, 50.0)];
	nameCaption.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
	nameCaption.textAlignment = NSTextAlignmentCenter;
	nameCaption.textColor = [UIColor darkTextColor];
	nameCaption.text = [_place.dishes[indexPath.row] componentsSeparatedByString:@"; "][0];
	nameCaption.alpha = 0.0;
	
	[keyWindow addSubview:giantNutrition];
	[giantNutrition addSubview:blurBacking];
	[giantNutrition addSubview:nutritionImage];
	[giantNutrition addSubview:nameCaption];
	
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
		giantNutrition.frame = keyWindow.bounds;
		nutritionImage.center = CGPointMake(giantNutrition.center.x, giantNutrition.center.y + 30.0);
		nameCaption.alpha = 1.0;
	} completion:nil];
}

- (void)dismissGiantView:(UIButton *)giantNutrition {
	[UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
		giantNutrition.alpha = 0.0;
	} completion:^(BOOL finished) {
		[giantNutrition removeFromSuperview];
	}];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end
