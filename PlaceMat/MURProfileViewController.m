//
//  MURProfileViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURProfileViewController.h"

@implementation MURProfileViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.title = @"Profile";
	self.view.backgroundColor = [MURTheme backgroundColor];
	self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initForDefaultSwitcher];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
#pragma mark - UITableViewDataSource

@end
