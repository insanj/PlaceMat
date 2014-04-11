//
//  MURProfileViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURProfileViewController.h"

#define DEBUG_NAME @"Julian Weiss"

@implementation MURProfileViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.title = @"Profile";
	self.view.backgroundColor = [MURTheme backgroundColor];
	self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initWithNavigationController:self.navigationController];
	
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
	[refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refresh;
}

- (void)refreshTable:(UIRefreshControl *)sender {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[sender endRefreshing];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

		// NSIndexSet *allSections = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, [self.tableView numberOfSections])];
		// [self.tableView reloadSections:allSections withRowAnimation:UITableViewRowAnimationAutomatic];
		[self.tableView reloadData];
	});
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate/DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 5; // Self, Recent Activity, Friends, Dishes, Places
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50.0;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
	
	UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
	header.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
	header.alpha = 0.85;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		default:
		case 0:
			return DEBUG_NAME;
		case 1:
			return @"Recent Activity";
		case 2:
			return @"Friends";
		case 3:
			return @"Dishes";
		case 4:
			return @"Places";
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return 100.0;
	}
	
	return 50.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 1;
	}
	
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier;
	switch (indexPath.section) {
		default:
		case 0:
			identifier = @"SelfCell";
			break;
		case 1:
			identifier = @"ActivityCell";
			break;
		case 2:
			identifier = @"FriendsCell";
			break;
		case 3:
			identifier = @"DishesCell";
			break;
		case 4:
			identifier = @"PlacesCell";
			break;
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
	}
	
	return cell;
}

@end
