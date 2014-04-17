//
//  MURTableViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURTableViewController.h"

@implementation MURTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.view.backgroundColor = [MURTheme backgroundColor];
	self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initWithNavigationController:self.navigationController];
	self.navigationItem.rightBarButtonItem = [[MURCheckinButtonItem alloc] initWithDefaults];
	self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end