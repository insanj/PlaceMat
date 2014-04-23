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
#import "MURSocialViewController.h"
#import "MURSettingsViewController.h"
#import "MURBlurView.h"

#define SNAP_DAMPING 0.4
#define BUBBLE_SEPARATION 10.0

@implementation MURBarSwitcherItem

// Custom initializer that creates the basic "chevron" switcher view
- (instancetype)initWithNavigationController:(UINavigationController *)arg1 {
	MURSwitcherButton *chevron = [[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"Menu"]];
	[chevron addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
	
	if ((self = [super initWithCustomView:chevron])) {
		_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.customView];
		_controller = arg1;
	}
	
	return self;
}

- (void)shootBalloons {
	[(MURSwitcherButton *)self.customView removeTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
	
	UIWindow *actingBox = [UIApplication sharedApplication].keyWindow;
	CGPoint origin = [actingBox convertPoint:self.customView.frame.origin fromView:self.customView.superview];
	CGRect frame = CGRectMake(origin.x, origin.y, self.customView.frame.size.width, self.customView.frame.size.height);
	
	// First, add the back overlay (like in CC).
	_overlay = [[UIButton alloc] initWithFrame:actingBox.frame];
	_overlay.backgroundColor = [UIColor darkGrayColor];
	_overlay.alpha = 0.0;
	[_overlay addTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchUpInside];
	[actingBox addSubview:_overlay];
	
	// Then, create the individual switcher buttons, and initialize them
	_profile = [[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"Profile"]];
	_dining = [[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"Dining"]];
	_social = [[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"Social"]];
	_settings = [[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"Settings"]];
	_profile.frame = _dining.frame = _social.frame = _settings.frame = frame;
	_profile.alpha = _dining.alpha = _social.alpha = _settings.alpha = 0.0;
	_profile.tag = 0; _dining.tag = 1; _social.tag = 2; _settings.tag = 3;

	[_profile addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	[_dining addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	[_social addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	[_settings addTarget:self action:@selector(pushControllerBasedOn:) forControlEvents:UIControlEventTouchUpInside];
	
	CGRect profileSnapFrame = _profile.frame;
	profileSnapFrame.origin.y += _profile.frame.size.height + BUBBLE_SEPARATION;
		
	CGRect diningSnapFrame = profileSnapFrame;
	diningSnapFrame.origin.y += _dining.frame.size.height + BUBBLE_SEPARATION;
	
	CGRect socialSnapFrame = diningSnapFrame;
	socialSnapFrame.origin.y += _social.frame.size.height + BUBBLE_SEPARATION;

	CGRect settingsSnapFrame = socialSnapFrame;
	settingsSnapFrame.origin.y += _settings.frame.size.height + BUBBLE_SEPARATION;
	
	// Create a nice switcher backing view
	CGRect switcherBackFrame = frame;
	switcherBackFrame.origin.y -= 5.0;
	switcherBackFrame.size.width += 10.0;
	switcherBackFrame.origin.x -= 5.0;
	
	CGRect switcherBackSnapFrame = switcherBackFrame;
	switcherBackSnapFrame.size.height = (settingsSnapFrame.origin.y + settingsSnapFrame.size.height) - frame.origin.y + 10.0;

	_switcherBack = [[UIView alloc] initWithFrame:switcherBackFrame];
	_switcherBack.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
	_switcherBack.layer.masksToBounds = YES;
	_switcherBack.layer.cornerRadius = 7.0;
	_switcherBack.hidden = YES;
	[_overlay addSubview:_switcherBack];
	
	[actingBox addSubview:_profile];
	[actingBox addSubview:_dining];
	[actingBox addSubview:_social];
	[actingBox addSubview:_settings];
	
	CGFloat motionRelativeValue = 8.0;
	UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	verticalMotionEffect.minimumRelativeValue = @(-motionRelativeValue);
	verticalMotionEffect.maximumRelativeValue = @(motionRelativeValue);
	
	UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	horizontalMotionEffect.minimumRelativeValue = @(-motionRelativeValue);
	horizontalMotionEffect.maximumRelativeValue = @(motionRelativeValue);
	
	UIMotionEffectGroup *group = [UIMotionEffectGroup new];
	group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
	[_switcherBack addMotionEffect:group];
	[_profile addMotionEffect:group];
	[_dining addMotionEffect:group];
	[_social addMotionEffect:group];
	[_settings addMotionEffect:group];

	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:SNAP_DAMPING initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_switcherBack.hidden = NO;
		
		/*CAFilter* filter = [CAFilter filterWithName:@"gaussianBlur"];
		[filter setValue:@(20.0) forKey:@"inputRadius"];
		[filter setValue:@(YES) forKey:@"inputHardEdges"];
		_switcherBack.layer.filters = @[filter];*/
		
		_overlay.alpha = 0.75;
		_profile.alpha = _dining.alpha = _social.alpha = _settings.alpha = 1.0;
		
		_switcherBack.frame = switcherBackSnapFrame;
		_profile.frame = profileSnapFrame;
		_dining.frame = diningSnapFrame;
		_social.frame = socialSnapFrame;
		_settings.frame = settingsSnapFrame;
	} completion:^(BOOL finished){
	}];
	
	[(MURSwitcherButton *)self.customView addTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchUpInside];
}

- (void)suckBalloons {
	[(MURSwitcherButton *)self.customView removeTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchUpInside];
	
	UIWindow *actingBox = [UIApplication sharedApplication].keyWindow;
	CGPoint origin = [actingBox convertPoint:self.customView.frame.origin fromView:self.customView.superview];
	CGRect frame = CGRectMake(origin.x, origin.y, self.customView.frame.size.width, self.customView.frame.size.height);
		
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		_switcherBack.hidden = YES;
		
		_profile.frame = _dining.frame = _social.frame = _settings.frame = frame;
		_overlay.alpha = _profile.alpha = _dining.alpha = _social.alpha = _settings.alpha = 0.0;
	} completion:^(BOOL finished){
		[_profile removeFromSuperview];
		[_dining removeFromSuperview];
		[_social removeFromSuperview];
		[_settings removeFromSuperview];
		
		[_switcherBack removeFromSuperview];
		[_overlay removeFromSuperview];
	}];
	
	[(MURSwitcherButton *)self.customView addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchUpInside];
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
		case 2:
			return [[MURSocialViewController alloc] init];
		case 3:
			return [[MURSettingsViewController alloc] init];
	}
}

- (CGRect)offsetFrameToView:(UIView *)receiver {
	CGRect working = receiver.frame;
	working.origin.y += (receiver.frame.size.height + 5.0);
	return working;
}

@end
