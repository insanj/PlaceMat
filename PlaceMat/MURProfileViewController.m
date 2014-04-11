//
//  MURProfileViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURProfileViewController.h"

#define DEBUG_NAME_YEAR @"Julian Weiss 2017"

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
			return nil;
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
		return 150.0;
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
		
		// No memory conservation here, because there'll only ever be one!
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelfCell"];
			CGFloat cellHeight = 150.0;
			CGFloat avatarHeight = cellHeight - 15.0;
			
			CGFloat padding = (cellHeight - avatarHeight) / 2.0;
			UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, avatarHeight, avatarHeight)];
			avatar.image = [UIImage imageNamed:@"Julian.jpg"];
			avatar.center = CGPointMake(cell.center.x, avatar.center.y);
			avatar.layer.masksToBounds = YES;
			avatar.layer.cornerRadius = 10.0;
						
			UIFont *nameFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
			CGFloat labelHeight = 25.0;
			
			NSString *firstName = [DEBUG_NAME_YEAR componentsSeparatedByString:@" "][0];
			CGSize firstNameSize = [firstName sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + 15.0, (cellHeight / 2.0) - (labelHeight * 2.0) + padding, firstNameSize.width, labelHeight)];
			firstNameLabel.font = nameFont;
			firstNameLabel.text = firstName;
			
			NSString *lastName = [DEBUG_NAME_YEAR componentsSeparatedByString:@" "][1];
			CGSize lastNameSize = [lastName sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *lastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + 15.0, (cellHeight / 2.0) - labelHeight + padding, lastNameSize.width, labelHeight)];
			lastNameLabel.font = nameFont;
			lastNameLabel.text = lastName;
			
			NSString *classYear = [DEBUG_NAME_YEAR componentsSeparatedByString:@" "][2];
			CGSize classYearSize = [classYear sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *classYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + 15.0, (cellHeight / 2.0) + padding, classYearSize.width, labelHeight)];
			classYearLabel.font = nameFont;
			classYearLabel.text = classYear;
			
			UIButton *cog = [[UIButton alloc] initWithFrame:CGRectMake(avatar.frame.origin.x - (50.0 + 15.0), avatar.center.y - (50.0 / 1.9), 50.0, 50.0)];
			[cog setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
			cog.alpha = 0.8;
			
			[cell.contentView addSubview:cog];
			[cell.contentView addSubview:avatar];
			[cell.contentView addSubview:firstNameLabel];
			[cell.contentView addSubview:lastNameLabel];
			[cell.contentView addSubview:classYearLabel];
		}
		

		
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
