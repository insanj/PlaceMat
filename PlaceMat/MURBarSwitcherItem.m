//
//  MURBarSwitcherItem.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURBarSwitcherItem.h"

#import "MURProfileViewController.h"
#import "MURDiningViewController.h"

#define SNAP_DAMPING 0.4
#define BUBBLE_SEPARATION 10.0
#define DEFAULT_IMAGE_SIZE (CGSize){30.0, 30.0}

@implementation MURBarSwitcherItem

- (instancetype)initWithNavigationController:(UINavigationController *)arg1 {
	UIImage *chevronImage = [self defaultImageSizeWithName:@"Chevron"];

	UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, chevronImage.size.width, chevronImage.size.height)];
	[customView setImage:chevronImage forState:UIControlStateNormal];
	[customView addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
	customView.showsTouchWhenHighlighted = YES;

	if ((self = [super initWithCustomView:customView])) {
		_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.customView];
		_controller = arg1;
	}
	
	return self;
}

- (UIImage *)defaultImageSizeWithName:(NSString *)name {
	UIGraphicsBeginImageContextWithOptions(DEFAULT_IMAGE_SIZE, NO, 4.0);
    [[UIImage imageNamed:name] drawInRect:CGRectMake(0, 0, DEFAULT_IMAGE_SIZE.width, DEFAULT_IMAGE_SIZE.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

- (void)shootBalloons {
	[(UIButton *)self.customView removeTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
	
	UIWindow *actingBox = [UIApplication sharedApplication].keyWindow;
	CGPoint origin = [actingBox convertPoint:self.customView.frame.origin fromView:self.customView.superview];
	CGRect frame = CGRectMake(origin.x, origin.y, self.customView.frame.size.width, self.customView.frame.size.height);
	
	_profile = [[UIButton alloc] initWithFrame:frame];
	_dining = [[UIButton alloc] initWithFrame:frame];

	[_profile setImage:[self defaultImageSizeWithName:@"Profile"] forState:UIControlStateNormal];
	[_dining setImage:[self defaultImageSizeWithName:@"Dining"] forState:UIControlStateNormal];

	[_profile addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	[_dining addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	
	_profile.userInteractionEnabled = _dining.userInteractionEnabled = YES;
	_profile.showsTouchWhenHighlighted = _dining.userInteractionEnabled = YES;
	_profile.alpha = _dining.alpha = 0.0;
	
	_profile.tag = 0;
	_dining.tag = _profile.tag + 1;
	
	[actingBox addSubview:_profile];
	[actingBox addSubview:_dining];
	
	CGRect profileSnapFrame = _profile.frame;
	profileSnapFrame.origin.y += _profile.frame.size.height + BUBBLE_SEPARATION;
		
	CGRect diningSnapFrame = profileSnapFrame;
	diningSnapFrame.origin.y += _dining.frame.size.height + BUBBLE_SEPARATION;
	
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:SNAP_DAMPING initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[_profile setAlpha:1.0];
		[_dining setAlpha:1.0];
		
		[_profile setFrame:profileSnapFrame];
		[_dining setFrame:diningSnapFrame];
	} completion:^(BOOL finished){
		// air
	}];
	
	[(UIButton *)self.customView addTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchUpInside];
}

- (void)suckBalloons {
	[(UIButton *)self.customView removeTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchUpInside];
	
	UIWindow *actingBox = [UIApplication sharedApplication].keyWindow;
	CGPoint origin = [actingBox convertPoint:self.customView.frame.origin fromView:self.customView.superview];
	CGRect frame = CGRectMake(origin.x, origin.y, self.customView.frame.size.width, self.customView.frame.size.height);
		
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[_profile setFrame:frame];
		[_dining setFrame:frame];
		
		[_profile setAlpha:0.0];
		[_dining setAlpha:0.0];
	} completion:^(BOOL finished){
		[_profile removeFromSuperview];
		[_dining removeFromSuperview];
	}];
	
	[(UIButton *)self.customView addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushControllerBasedOn:(UIButton *)sender {
	[self suckBalloons];
	
	UIViewController *transitionController = [self viewControllerForTag:sender.tag];
	if (![transitionController isKindOfClass:_controller.topViewController.class]) {
		[_controller setViewControllers:@[transitionController] animated:YES];
	}
}

- (UIViewController *)viewControllerForTag:(NSUInteger)tag {
	switch (tag) {
		default:
		case 0:
			return [[MURProfileViewController alloc] init];
		case 1:
			return [[MURDiningViewController alloc] init];
	}
}

- (CGRect)offsetFrameToView:(UIView *)receiver {
	CGRect working = receiver.frame;
	working.origin.y += (receiver.frame.size.height + 5.0);
	return working;
}


@end
