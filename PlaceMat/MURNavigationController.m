//
//  MURNavigationController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURNavigationController.h"

@implementation MURNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationBar.barTintColor = [MURTheme tintColor];
	self.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated {
//	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"PlaceMatRan"]) {
		NSLog(@"Detected user hasn't run before...");
		
		[self pushViewController:[[MURFirstRunViewController alloc] init] animated:YES];
		
		UIBarButtonItem *hideButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideRanView)];
		[self.navigationBar.topItem setRightBarButtonItem:hideButton];
		[self.navigationBar.topItem setHidesBackButton:YES animated:NO];

//	}
	
	[super viewWillAppear:animated];
}

- (void)hideRanView {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PlaceMatRan"];

	[self popToRootViewControllerAnimated:YES];
	[self.navigationItem setHidesBackButton:NO animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
