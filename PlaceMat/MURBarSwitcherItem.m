//
//  MURBarSwitcherItem.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURBarSwitcherItem.h"
#define SNAP_DAMPING 0.4

@implementation MURBarSwitcherItem

- (instancetype)initForDefaultSwitcher {
	UIImage *image = [UIImage imageNamed:@"Chevron"];
	UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
	[customView setImage:image forState:UIControlStateNormal];
	[customView addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchDown];
	
	if ((self = [super initWithCustomView:customView])) {
		_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.customView];
	}
	
	return self;
}

- (void)shootBalloons {
	[(UIButton *)self.customView removeTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchDown];
	
	CGPoint origin = self.customView.superview.frame.origin;
	CGRect frame = CGRectMake(origin.x, origin.y - (self.customView.frame.size.height / 1.25), self.customView.frame.size.width, self.customView.frame.size.height);
	
	_profile = [[UIButton alloc] initWithFrame:frame];
	_profile.alpha = 0.0;
	[_profile setImage:[UIImage imageNamed:@"Profile"] forState:UIControlStateNormal];
	[self.customView addSubview:_profile];
	
	CGRect profileSnapFrame = _profile.frame;
	profileSnapFrame.origin.y += _profile.frame.size.height + 5.0;
		
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:SNAP_DAMPING initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[_profile setAlpha:1.0];
		[_profile setFrame:profileSnapFrame];
	} completion:^(BOOL finished){
	//	[self.context completeTransition:YES];
	}];
	
	[(UIButton *)self.customView addTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchDown];
}

- (void)suckBalloons {
	[(UIButton *)self.customView removeTarget:self action:@selector(suckBalloons) forControlEvents:UIControlEventTouchDown];
	
	CGPoint origin = self.customView.superview.frame.origin;
	CGRect frame = CGRectMake(origin.x, origin.y - (self.customView.frame.size.height / 1.25), self.customView.frame.size.width, self.customView.frame.size.height);
		
	[UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[_profile setFrame:frame];
		[_profile setAlpha:0.0];
	} completion:^(BOOL finished){
		[_profile removeFromSuperview];
	}];
	
	[(UIButton *)self.customView addTarget:self action:@selector(shootBalloons) forControlEvents:UIControlEventTouchDown];
}

- (CGRect)offsetFrameToView:(UIView *)receiver {
	CGRect working = receiver.frame;
	working.origin.y += (receiver.frame.size.height + 5.0);
	return working;
}


@end
