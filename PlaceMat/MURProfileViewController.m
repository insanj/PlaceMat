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
	_user = [[MURUser alloc] initWithPath:[MURUser pathForDebugUser]];
	
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
	return 4; // Self, Recent Activity, Friends, Dishes, --Places--
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
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return 150.0;
	}
	
	return 50.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		default:
		case 0:
			return 1;
		case 1:
			return _user.activities.count;
		case 2:
			return _user.friends.count;
		case 3:
			return _user.dishes.count;
	}
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
			avatar.image = _user.avatar;
			avatar.layer.masksToBounds = YES;
			avatar.layer.cornerRadius = 10.0;
			
			CGFloat xPadding = avatar.frame.origin.x + avatar.frame.size.width + padding;

			UIFont *nameFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:28.0];
			CGSize nameSize = [_user.name sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + padding, padding + 15.0, nameSize.width, nameSize.height)];
			nameLabel.font = nameFont;
			nameLabel.text = _user.name;
			
			UIFont *classYearFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
			CGSize classYearSize = [_user.classOf sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			UILabel *classYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + padding, nameSize.height + 15.0, classYearSize.width, classYearSize.height)];
			classYearLabel.font = classYearFont;
			classYearLabel.textColor = [UIColor darkGrayColor];
			classYearLabel.text = _user.classOf;
			
			CGFloat buttonHeight = 30.0;
			UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(xPadding, cellHeight - (buttonHeight * 2), cell.frame.size.width / 2.0, buttonHeight)];
			actionButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
			actionButton.layer.masksToBounds = YES;
			actionButton.layer.cornerRadius = 7.0;
			
			[actionButton setTitle:[self randomForkAction] forState:UIControlStateNormal];
			[actionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
			[actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
			[actionButton setBackgroundImage:[MURTheme imageFromColor:[UIColor darkGrayColor] withSize:actionButton.frame.size] forState:UIControlStateHighlighted];
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
		
		//CGFloat labelWidth = self.view.frame.size.width - 50.0;
		NSArray *activity = [_user.activities[indexPath.row] componentsSeparatedByString:@"; "];
			
		NSString *labelRawText = activity[0];
		NSString *labelText = @"";
		for (int i = 0; i < labelRawText.length; i++) {
			if ((i+1) % 29 == 0) {
				labelText = [labelText stringByAppendingString:@"\n"];
			}
			
			labelText = [labelText stringByAppendingFormat:@"%c", [labelRawText characterAtIndex:i]];
		}

		cell.textLabel.text = labelText;
		cell.textLabel.numberOfLines = 2;
		cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.textLabel.minimumScaleFactor = 0.1;
		cell.textLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
		
		if (activity.count > 1) {
			cell.detailTextLabel.text = activity[1];
			cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
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
	NSString __block *replaced;
	if ([button.titleLabel.text rangeOfString:@"Un-"].location != NSNotFound) {
		replaced = [NSString stringWithFormat:@"%@!", [button.titleLabel.text componentsSeparatedByString:@"Un-"][1]];
	}
	
	else if ([button.titleLabel.text rangeOfString:@"ed"].location == NSNotFound) {
		replaced = [NSString stringWithFormat:@"%@ed!", [button.titleLabel.text componentsSeparatedByString:@" "][0]];
	}
	
	else {
		replaced = [NSString stringWithFormat:@"Un-%@", [button.titleLabel.text componentsSeparatedByString:@"!"][0]];
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		[button setTitle:replaced forState:UIControlStateNormal];
	});
}

@end
