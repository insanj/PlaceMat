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
	if (YES || ![[NSUserDefaults standardUserDefaults] boolForKey:@"PlaceMatRan"]) {
		NSLog(@"Detected user hasn't run before...");		
		[self pushViewController:[[MURFirstRunViewController alloc] init] animated:YES];
	}
	
	[super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
