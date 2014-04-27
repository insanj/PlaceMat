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
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [super viewDidLoad];

	if ([_name isEqualToString:@"Profile"]) {
		self.navigationItem.leftBarButtonItem = [[MURBarSwitcherItem alloc] initWithNavigationController:self.navigationController];
	}
	
	else {
		self.navigationItem.leftBarButtonItem = nil;
	}
	
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
	[refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refresh;
	
	self.tableView.delaysContentTouches = NO;
	self.title = [_name componentsSeparatedByString:@" "][0];
}

- (instancetype)init {
	self = [super init];
	
	_name = @"Profile";
	_user = [[MURUser alloc] initWithPath:[MURUser pathForDebugUser]];
	return self;
}

- (instancetype)initWithName:(NSString *)name {
	self = [super init];
	
	_name = name;
	_user = [[MURUser alloc] initWithPath:[MURUser pathForName:name]];
	return self;
}

- (void)refreshTable:(UIRefreshControl *)sender {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self performSelector:@selector(didFinishLoadingTableData:) withObject:sender afterDelay:1.0];
}

- (void) didFinishLoadingTableData:(UIRefreshControl*)sender {
    [sender endRefreshing];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.tableView beginUpdates];
    NSIndexSet *allSections = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, [self.tableView numberOfSections])];
    [self.tableView reloadSections:allSections withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate/DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4; // Self, Recent Activity, Friends, Dishes, --Places--
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return section == 0 ? 0.0 : 35.0;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
	UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
	header.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
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
			avatar.contentMode = UIViewContentModeScaleAspectFill;
			
			CGFloat xPadding = avatar.frame.origin.x + avatar.frame.size.width + padding;

			UIFont *nameFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:28.0];
			CGSize nameSize = [_user.name sizeWithAttributes:@{NSFontAttributeName : nameFont}];
			CGRect nameRect = CGRectMake(avatar.frame.origin.x + avatar.frame.size.width + padding, padding + 15.0, 0, nameSize.height);
			nameRect.size.width = cell.frame.size.width - nameRect.origin.x - padding;
			UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameRect];
			nameLabel.font = nameFont;
			nameLabel.text = _user.name;
			nameLabel.adjustsFontSizeToFitWidth = YES;
			nameLabel.minimumScaleFactor = 0.5;
			
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
			
			if ([_name isEqualToString:@"Profile"]) {
				[actionButton setTitle:@"Create status..." forState:UIControlStateNormal];
				[actionButton addTarget:self action:@selector(createStatus:) forControlEvents:UIControlEventTouchUpInside];
			}
			
			else {
				[actionButton setTitle:[self randomForkAction] forState:UIControlStateNormal];
				[actionButton addTarget:self action:@selector(forkUser:) forControlEvents:UIControlEventTouchUpInside];
			}
			
			[actionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
			[actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
			[actionButton setBackgroundImage:[MURTheme imageFromColor:[UIColor colorWithWhite:0.9 alpha:1.0] withSize:actionButton.frame.size] forState:UIControlStateNormal];
			[actionButton setBackgroundImage:[MURTheme imageFromColor:[UIColor darkGrayColor] withSize:actionButton.frame.size] forState:UIControlStateHighlighted];
			
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
			cell.selectionStyle = UITableViewCellSelectionStyleNone;

			CGRect wrappedFrame = CGRectMake(15.0, 5.0, cell.frame.size.width - 110.0, cell.frame.size.height);
			UILabel *wrapping = [[UILabel alloc] initWithFrame:wrappedFrame];
			wrapping.tag = 1;
			[cell.contentView addSubview:wrapping];
		}
		
		//CGFloat labelWidth = self.view.frame.size.width - 50.0;
		NSArray *activity = [_user.activities[indexPath.row] componentsSeparatedByString:@"; "];
		NSString *labelText = activity[0];
		
		UILabel *wrapping = (UILabel *)[cell.contentView viewWithTag:1];
		wrapping.text = labelText;
		wrapping.numberOfLines = 2;
		wrapping.lineBreakMode = NSLineBreakByWordWrapping;
		wrapping.adjustsFontSizeToFitWidth = YES;
		wrapping.minimumScaleFactor = 0.1;
		wrapping.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
		
		if (activity.count > 1) {
			cell.detailTextLabel.text = activity[1];
			cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
		}
	} // activity cell
	
	else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCell"];
		}
		
		NSString *friend = _user.friends[indexPath.row];
		cell.textLabel.text = friend;
		cell.textLabel.numberOfLines = 1;
		cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.textLabel.minimumScaleFactor = 0.1;
		cell.textLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
		
		UIImageView *thumbnail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[friend componentsSeparatedByString:@" "][0]]];
		thumbnail.layer.masksToBounds = YES;
		thumbnail.layer.cornerRadius = 7.0;
		thumbnail.contentMode = UIViewContentModeScaleAspectFill;
		thumbnail.frame = CGRectMake(0.0, 5.0, 45.0, 45.0);
								  
		cell.accessoryView = thumbnail;
	} // friends cell
	
	else if (indexPath.section == 3) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"DishesCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DishesCell"];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;

			CGRect wrappedFrame = CGRectMake(15.0, 2.5, cell.frame.size.width - 110.0, cell.frame.size.height);
			UILabel *wrapping = [[UILabel alloc] initWithFrame:wrappedFrame];
			wrapping.tag = 1;
			[cell.contentView addSubview:wrapping];
		}
		
		NSArray *dish = [_user.dishes[indexPath.row] componentsSeparatedByString:@"; "];
		
		NSString *labelText = dish[0];
		
		UILabel *wrapping = (UILabel *)[cell.contentView viewWithTag:1];
		wrapping.text = labelText;
		wrapping.numberOfLines = 2;
		wrapping.lineBreakMode = NSLineBreakByTruncatingTail;
		wrapping.adjustsFontSizeToFitWidth = YES;
		wrapping.minimumScaleFactor = 0.1;
		wrapping.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
		
		if (dish.count > 1) {
			cell.detailTextLabel.text = dish[1];
			cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
		}
	} // dishes cell
	
	for (id obj in cell.subviews) {
		if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"]) {
			UIScrollView *scroll = (UIScrollView *) obj;
			scroll.delaysContentTouches = NO;
			break;
		}
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	if ([cell.reuseIdentifier isEqualToString:@"FriendsCell"]) {
		[self.navigationController pushViewController:[[MURProfileViewController alloc] initWithName:cell.textLabel.text] animated:YES];
	}
}

- (NSString *)randomForkAction {
	int rand = arc4random_uniform(6);
	switch (rand) {
		default:
		case 0:
		case 1:
			return @"Fork me!";
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

- (void)createStatus:(UIButton *)button {
	UIAlertView *statusAlert = [[UIAlertView alloc] initWithTitle:@"New Status" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Post", nil];
	statusAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
	statusAlert.delegate = self;
	[statusAlert textFieldAtIndex:0].placeholder = @"I'm feeling...";
	[statusAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [alertView cancelButtonIndex]) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			UIAlertView *confirmAlert = [[UIAlertView alloc] initWithTitle:@"Status Posted" message:@"Your status has been posted and shared with your nearby friends successfully." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Sweet!", nil];
			[confirmAlert show];
		});
	}
}

@end
