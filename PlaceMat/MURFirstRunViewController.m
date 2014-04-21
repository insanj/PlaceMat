//
//  MURFirstRunViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/21/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURFirstRunViewController.h"

@implementation MURFirstRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"PlaceMat";
	self.view.backgroundColor = [MURTheme backgroundColor];
	//self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initWithNavigationController:self.navigationController];
//	self.navigationItem.rightBarButtonItem = [[MURCheckinButtonItem alloc] initWithDefaults];
//	self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
