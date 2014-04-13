//
//  MURProfileViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURProfileViewController.h"

#define DEBUG_NAME @"Julian Weiss"
#define DEBUG_YEAR @"Class of 2017"

@implementation MURProfileViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	self.title = @"Profile";
	  
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
	[refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refresh;
}

- (void)refreshTable:(UIRefreshControl *)sender {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[sender endRefreshing];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

		NSIndexSet *allSections = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, [self.tableView numberOfSections])];
		[self.tableView reloadSections:allSections withRowAnimation:UITableViewRowAnimationAutomatic];
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
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			CGFloat cellHeight = 150.0;
			CGFloat avatarHeight = cellHeight - 15.0;
			CGFloat padding = (cellHeight - avatarHeight) / 2.0;
			
			UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, avatarHeight, avatarHeight)];
			avatar.image = [UIImage imageNamed:@"Julian.jpg"];
			avatar.layer.masksToBounds = YES;
			avatar.layer.cornerRadius = 10.0;
			
			CGFloat xPadding = avatar.frame.origin.x + avatar.frame.size.width + padding;

			UIFont *nameFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:28.0];
			CGSize nameSize = [DEBUG_NAME sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + padding, padding + 15.0, nameSize.width, nameSize.height)];
			nameLabel.font = nameFont;
			nameLabel.text = DEBUG_NAME;
			
			UIFont *classYearFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
			CGSize classYearSize = [DEBUG_YEAR sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *classYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + padding, nameSize.height + 15.0, classYearSize.width, classYearSize.height)];
			classYearLabel.font = classYearFont;
			classYearLabel.textColor = [UIColor darkGrayColor];
			classYearLabel.text = DEBUG_YEAR;
			
			CGFloat buttonHeight = 30.0;
			UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(xPadding, cellHeight - (buttonHeight * 2), cell.frame.size.width / 2.0, buttonHeight)];
			actionButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
			actionButton.layer.masksToBounds = YES;
			actionButton.layer.cornerRadius = 7.0;
			
			[actionButton setTitle:[self randomForkAction] forState:UIControlStateNormal];
			[actionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
			[actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
			[actionButton addTarget:self action:@selector(forkUser:) forControlEvents:UIControlEventTouchUpInside];
			
			[cell.contentView addSubview:avatar];
			[cell.contentView addSubview:nameLabel];
			[cell.contentView addSubview:classYearLabel];
			[cell.contentView addSubview:actionButton];
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

- (NSString *)randomForkAction {
	int rand = arc4random_uniform(6);
	switch (rand) {
		default:
		case 0:
			return @"Fork me!";
		case 1:
			return @"Knife me!";
		case 2:
			return @"Spoon me!";
		case 3:
			return @"Spork me!";
		case 4:
			return @"Ladel me!";
		case 5:
			return @"Whisk me!";
	}
}

- (void)forkUser:(UIButton *)button {

}

@end
