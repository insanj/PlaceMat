//
//  MURSettingsViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURSettingsViewController.h"

@implementation MURSettingsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.title = @"Settings";
	
	// All keys are sections (with titles), values cells (under most recent subsection).
	//				 Section Subsection			  Rows
	_specifiers = @{ @"Account" :
						 @[@{@"Change Username" : @[UITextField.class]},
						   @{@"Change Password" : @[UITextField.class]},
						   @{@"Change Email" : @[UITextField.class]}],
					 @"Restrictions" :
						 @[@{@"Dietary Restrictions" : @[UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class]},
						   @{@"Religious Restrictions" : @[UISwitch.class, UISwitch.class]}]
					};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger counter = 0;
	for (NSString *key in _specifiers.allKeys) {
		counter++;
		
		NSArray *cells = _specifiers[key];
		for (int i = 0; i < cells.count; i++) {
			counter++;
		}
	}
	
	return counter;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSInteger counter = 0;
	for (NSString *key in _specifiers.allKeys) {
		if (counter++ == section) {
			return key;
		}
		
		NSArray *cells = _specifiers[key];
		for (NSDictionary *thisCell in cells) {
			for (NSString *keykey in thisCell.allKeys) {
				if (counter++ == section) {
					return keykey;
				}
			}
		}
	}
	
	return @"ohno";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
	UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
	header.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
	header.alpha = 0.85;

	NSInteger counter = 0;
	for (NSString *key in _specifiers.allKeys) {
		if (counter++ == section) {
			header.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
			return;
		}
		
		NSArray *cells = _specifiers[key];
		for (NSDictionary *thisCell in cells) {
			for (NSString *keykey in thisCell.allKeys) {
				if (counter++ == section) {
					header.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
					return;
				}
			}
		}
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	NSInteger counter = 0;
	for (NSString *key in _specifiers.allKeys) {
		if (counter++ == section) {
			return 50.0;
		}
		
		NSArray *cells = _specifiers[key];
		for (NSDictionary *thisCell in cells) {
			for (NSString *keykey in thisCell.allKeys) {
				if (counter++ == section) {
					return 40;
				}
			}
		}
	}
	
	return 10.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger counter = 0;
	for (NSString *key in _specifiers.allKeys) {
		if (counter++ == section) {
			return 0;
		}
		
		NSArray *cells = _specifiers[key];
		for (NSDictionary *thisCell in cells) {
			for (NSString *keykey in thisCell.allKeys) {
				if (counter++ == section) {
					return ((NSArray *)thisCell[keykey]).count;
				}
			}
		}
	}
	
	return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0;
}

/*
 
 _specifiers = @{ @"Account" :
 @[@{@"Change Username" : @[UITextField.class]},
 @{@"Change Password" : @[UITextField.class]},
 @{@"Change Email" : @[UITextField.class]}],
 @"Restrictions" :
 @[@{@"Dietary Restrictions" : @[UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class, UISwitch.class]},
 @{@"Religious Restrictions" : @[UISwitch.class, UISwitch.class]}]
 };
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell; NSString *identifier;
	CGRect cellFrame = cell.frame;
	cellFrame.size.height = 50.0;
	
	NSString *sectionName = [self tableView:tableView titleForHeaderInSection:indexPath.section];
	if ([sectionName isEqualToString:@"Change Username"]) {
		identifier = @"EntryCell";
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			UITextField *nameEntryField = [[UITextField alloc] initWithFrame:cellFrame];
			nameEntryField.delegate = self;
			nameEntryField.tag = 1;
			
			[cell.contentView addSubview:nameEntryField];
		}
		
		UITextField *usernameEntry = (UITextField *)[cell.contentView viewWithTag:1];
		usernameEntry.placeholder = @"new username";
	}
	
	else if ([sectionName isEqualToString:@"Change Password"]) {
		identifier = @"EntryCell";
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			UITextField *nameEntryField = [[UITextField alloc] initWithFrame:cellFrame];
			nameEntryField.delegate = self;
			nameEntryField.tag = 1;
			
			[cell.contentView addSubview:nameEntryField];
		}
		
		UITextField *usernameEntry = (UITextField *)[cell.contentView viewWithTag:1];
		usernameEntry.placeholder = @"new password";
	}
	
	else if ([sectionName isEqualToString:@"Change Email"]) {
		identifier = @"EntryCell";
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			UITextField *nameEntryField = [[UITextField alloc] initWithFrame:cellFrame];
			nameEntryField.delegate = self;
			nameEntryField.tag = 1;
			
			[cell.contentView addSubview:nameEntryField];
		}
		
		UITextField *usernameEntry = (UITextField *)[cell.contentView viewWithTag:1];
		usernameEntry.placeholder = @"new email";
	}
	
	else if ([sectionName isEqualToString:@"Dietary Restrictions"]) {
		identifier = @"SwitchCell";
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			UISwitch *restSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
			restSwitch.tag = 2;
			restSwitch.on = NO;
			cell.accessoryView = restSwitch;
		}
		
		UISwitch *restSwitch = (UISwitch *)[cell.contentView viewWithTag:2];
		if (indexPath.row == 0) {
			restSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"];
			[restSwitch addTarget:self action:@selector(switchForVegetarian) forControlEvents:UIControlEventValueChanged];
		}
		
	}
	
	return cell;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	return YES;
}

- (void)switchForVegetarian {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Vegetarian"];
}

@end
