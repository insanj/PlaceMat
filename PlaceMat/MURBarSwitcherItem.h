//
//  MURBarSwitcherItem.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "MURSwitcherButton.h"
#include "MURProfileViewController.h"
#include "MURDiningViewController.h"

@interface MURBarSwitcherItem : UIBarButtonItem {
	MURSwitcherButton *_profile, *_dining, *_social, *_settings;
	UIDynamicAnimator *_animator;
	UINavigationController *_controller;
	
	UIButton *_overlay;
	UIView *_switcherBack;
}


- (instancetype)initWithNavigationController:(UINavigationController *)arg1;

@end
