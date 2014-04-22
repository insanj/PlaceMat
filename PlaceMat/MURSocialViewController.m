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
