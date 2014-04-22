//
//  MURProfileViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURDiningViewController.h"

@implementation MURDiningViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.title = @"Dining";
	self.tableView.sectionIndexBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
	places = [self placesWithNames:@[@"Commons", @"Connections", @"Danforth", @"Douglass", @"Meliora", @"Pura Vida", @"Starbucks"]];
	
	NSMutableArray *running = [[NSMutableArray alloc] init];
	NSMutableArray *runningPlaces = [[NSMutableArray alloc] init];
	char lastFirst = '\0';
	for (MURPlace *s in places) {
		char thisFirst = [s.name characterAtIndex:0];
		if (thisFirst > lastFirst) {
			lastFirst = thisFirst;
			
			[runningPlaces addObject:[[NSMutableArray alloc] initWithObjects:s, nil]];
			[running addObject:[NSString stringWithFormat:@"%c", lastFirst]];
		}
		
		else {
			NSMutableArray *last = (NSMutableArray *)[runningPlaces lastObject];
			[last addObject:s];
		}
	}
		
	firstLetters = [NSArray arrayWithArray:running];
	placesBySection = [NSArray arrayWithArray:runningPlaces];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)placesWithNames:(NSArray *)names {
	NSMutableArray *running = [[NSMutableArray alloc] init];
	for (NSString *name in names) {
		[running addObject:[[MURPlace alloc] initWithName:name]];
	}
	
	return [NSArray arrayWithArray:running];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return firstLetters.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return firstLetters;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return firstLetters[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	char letter = [firstLetters[section] characterAtIndex:0];
	int amount = 0;
	for (int i = 0; i < places.count; i++) {
		NSString *name = ((MURPlace *)places[i]).name;
		if ([name characterAtIndex:0] == letter) {
			amount++;
		}
	}
	
	return amount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"DiningCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

		CGFloat height = 80.0, padding = 5.0;
	
		CGRect imageViewFrame = CGRectMake(padding, padding, 70.0, height - (padding * 2));
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.layer.masksToBounds = YES;
		imageView.layer.cornerRadius = 7.0;
		imageView.tag = 1;
		
		CGRect nameLabelFrame = CGRectMake(imageViewFrame.origin.x + imageViewFrame.size.width + (padding * 2), padding * 2, 0.0, 20.0);
		nameLabelFrame.size.width = cell.frame.size.width - nameLabelFrame.origin.x;
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
		nameLabel.numberOfLines = 1;
		nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
		nameLabel.tag = 2;
		
		UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelFrame.origin.x, nameLabelFrame.origin.y + nameLabelFrame.size.height + 2.0, nameLabelFrame.size.width, 20.0)];
		detailLabel.numberOfLines = 1;
		detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		detailLabel.font = [UIFont systemFontOfSize:16.0];
		detailLabel.tag = 3;
		
		UILabel *evenMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelFrame.origin.x, detailLabel.frame.origin.y + detailLabel.frame.size.height, nameLabelFrame.size.width, 20.0)];
		evenMoreLabel.numberOfLines = 1;
		evenMoreLabel.textColor = [UIColor darkGrayColor];
		evenMoreLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		evenMoreLabel.font = [UIFont systemFontOfSize:14.0];
		evenMoreLabel.tag = 4;
		
		[cell.contentView addSubview:imageView];
		[cell.contentView addSubview:nameLabel];
		[cell.contentView addSubview:detailLabel];
		[cell.contentView addSubview:evenMoreLabel];
	}
	
	//int idx = indexPath.row + indexPath.section;
	//if (indexPath.row == 0 && indexPath.section > 1){
	//	idx++;
	//}
	
	//long idx = indexPath.section == 0 ? indexPath.section + indexPath.row : (2 * indexPath.section) + (indexPath.row - 1);

	MURPlace *place = [placesBySection[indexPath.section] objectAtIndex:indexPath.row];
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
	imageView.image = place.avatar;
	
	UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
	nameLabel.text = place.name;
	
	UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
	detailLabel.text = place.description;
	
	UILabel *evenMoreLabel = (UILabel *)[cell viewWithTag:4];
	evenMoreLabel.text = [place.serving stringByAppendingString:[@" from " stringByAppendingString:place.time]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	MURPlaceViewController *placeController = [[MURPlaceViewController alloc] initWithPlace:[placesBySection[indexPath.section] objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:placeController animated:YES];
}

@end
