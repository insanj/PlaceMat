//
//  MURBarSwitcherItem.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MURBarSwitcherItem : UIBarButtonItem {
	UIButton *_profile, *_dining, *_social, *_settings;
	UIDynamicAnimator *_animator;
	UINavigationController *_controller;
}


- (instancetype)initWithNavigationController:(UINavigationController *)arg1;

@end
