//
//  MURSocialViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURSocialViewController.h"

@implementation MURSocialViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.title = @"Social";
	self.view.backgroundColor = [MURTheme backgroundColor];
	self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initWithNavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
#pragma mark - UITableViewDataSource

@end
