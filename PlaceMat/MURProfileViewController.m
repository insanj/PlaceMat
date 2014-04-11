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
	return section == 0 ? 0.0 : 45.0;
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
	
	UITableViewCell *cell;
	if (indexPath.section == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"SelfCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelfCell"];
			
			CGFloat padding = (100.0 - 85.0) / 2.0;
			UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, 85.0, 85.0)];
			avatar.layer.masksToBounds = YES;
			avatar.layer.cornerRadius = 7.0;
			avatar.tag = 1;
			
			[cell.contentView addSubview:avatar];
			
			NSString *firstName = [DEBUG_NAME componentsSeparatedByString:@" "][0];
			CGSize firstNameSize = [firstName sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
			UILabel *firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - firstNameSize.width - padding, (100 / 3.0) - padding, firstNameSize.width, firstNameSize.height)];
			firstNameLabel.font = [UIFont systemFontOfSize:18.0];
			[firstNameLabel setText:firstName];
			firstNameLabel.tag = 2;
			
			[cell.contentView addSubview:firstNameLabel];
		}
		
		UIImageView *taggedAvatar = (UIImageView *)[cell.contentView viewWithTag:1];
		[taggedAvatar setImage:[UIImage imageNamed:@"Julian.jpg"]];
		
	} // self cell
	
	else if (indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ActivityCell"];
		}
	} // activity cell
	
	else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FriendsCell"];
		}
	} // friends cell
	
	else if (indexPath.section == 3) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"DishesCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DishesCell"];
		}
	} // dishes cell
	
	else {
		cell = [tableView dequeueReusableCellWithIdentifier:@"PlacesCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PlacesCell"];
		}
	} // places cell
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
