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
	
	self.navigationBar.barTintColor = [MURTheme barTintColor];
    self.navigationBar.tintColor = [MURTheme tintColor];
    
	NSDictionary *attributes = @{NSForegroundColorAttributeName : [MURTheme tintColor]};
    self.navigationBar.titleTextAttributes = attributes;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"PlaceMatRan"]) {
		NSLog(@"Detected user hasn't run before...");		
		[self pushViewController:[[MURFirstRunViewController alloc] init] animated:YES];
	}
	
	[super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
