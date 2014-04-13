//
//  MURBarSwitcherItem.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURSwitcherButton.h"
#import "MURProfileViewController.h"
#import "MURDiningViewController.h"
#import "MURSocialViewController.h"
#import "MURSettingsViewController.h"
#import "MURBlurView.h"

@interface MURBarSwitcherItem : UIBarButtonItem {
	MURSwitcherButton *_profile, *_dining, *_social, *_settings;
	UIDynamicAnimator *_animator;
	UINavigationController *_controller;
	
	UIButton *_overlay;
	UIView *_switcherBack;
}


- (instancetype)initWithNavigationController:(UINavigationController *)arg1;

@end
