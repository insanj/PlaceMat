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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
