//
//  MURSocialViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURSocialViewController.h"

@implementation MURSocialViewController

- (instancetype)init {
	self = [super init];
	return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

	_activity = [MURUser chronologicalListOfUserActivitiesForSocialViewControllerTableViewControllerTableViewCellForRowAtIndexPath];
	self.title = @"Social";
	
	
	_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
	_searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    self.tableView.tableHeaderView = _searchBar;
	
	/*CGFloat searchBarPadding = _searchBar.frame.size.height + 5.0;
	self.tableView.contentOffset = CGPointMake(0.0, searchBarPadding * 2);
	//self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + searchBarPadding);
	self.tableView.contentInset = UIEdgeInsetsMake(-searchBarPadding, 0.0, 0.0, 0.0);
	[self.tableView addSubview:_searchBar];*/
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [self.tableView setContentOffset:CGPointMake(0, _searchBar.frame.size.height)];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _activity.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 55.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialCell"];
	NSString *rawActivity = _activity[indexPath.row];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SocialCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		CGRect wrappedFrame = CGRectMake(15.0, 5.0, cell.frame.size.width - 110.0, cell.frame.size.height);
		UILabel *wrapping = [[UILabel alloc] initWithFrame:wrappedFrame];
		wrapping.tag = 1;
		[cell.contentView addSubview:wrapping];
	}
		
	// CGFloat labelWidth = self.view.frame.size.width - 50.0;
	NSArray *activity = [rawActivity componentsSeparatedByString:@"; "];
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
	
	return cell;
}

@end
