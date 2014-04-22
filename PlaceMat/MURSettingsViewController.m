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
			for (int i = 0; i < thisCell.allKeys.count; i++) {
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
			return 40.0;
		}
		
		NSArray *cells = _specifiers[key];
		for (NSDictionary *thisCell in cells) {
			for (int i = 0; i < thisCell.allKeys.count; i++) {
				if (counter++ == section) {
					return 30.0;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell; NSString *identifier;
	CGRect cellFrame = CGRectMake(10.0, 0.0, self.view.frame.size.width, 50.0);
	
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
			
			if (indexPath.row != 5) {
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				UISwitch *restSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
				restSwitch.tag = 2;
				restSwitch.on = NO;
				cell.accessoryView = restSwitch;
			}
		}
		
		UISwitch *restSwitch = (UISwitch *)[cell.contentView viewWithTag:2];
		[restSwitch removeTarget:self action:nil forControlEvents:UIControlEventValueChanged];

		if (indexPath.row == 0) {
			cell.textLabel.text = @"Vegetarian";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"]];
			[restSwitch addTarget:self action:@selector(switchForVegetarian) forControlEvents:UIControlEventValueChanged];
		}
		
		else if (indexPath.row == 1) {
			cell.textLabel.text = @"Vegan";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Vegan"]];
			[restSwitch addTarget:self action:@selector(switchForVegan) forControlEvents:UIControlEventValueChanged];
		}
		
		else if (indexPath.row == 2) {
			cell.textLabel.text = @"Pescatarian";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Pescatarian"]];
			[restSwitch addTarget:self action:@selector(switchForPescatarian) forControlEvents:UIControlEventValueChanged];
		}
		
		else if (indexPath.row == 3) {
			cell.textLabel.text = @"Lactose Intolerant";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Lactose"]];
			[restSwitch addTarget:self action:@selector(switchForLactose) forControlEvents:UIControlEventValueChanged];
		}
		
		else if (indexPath.row == 4) {
			cell.textLabel.text = @"Gluten Free";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Gluten"]];
			[restSwitch addTarget:self action:@selector(switchForGluten) forControlEvents:UIControlEventValueChanged];
		}
	
		else {
			cell.textLabel.text = @"Allergies...";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Allergies"]];
			[restSwitch addTarget:self action:@selector(switchForGluten) forControlEvents:UIControlEventValueChanged];
		}
	}
	
	else if ([sectionName isEqualToString:@"Religious Restrictions"]) {
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
		[restSwitch removeTarget:self action:nil forControlEvents:UIControlEventValueChanged];
		
		if (indexPath.row == 0) {
			cell.textLabel.text = @"Kosher";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Kosher"]];
			[restSwitch addTarget:self action:@selector(switchForKosher) forControlEvents:UIControlEventValueChanged];
		}
		
		else {
			cell.textLabel.text = @"Halal";
			[restSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Halal"]];
			[restSwitch addTarget:self action:@selector(switchForHalal) forControlEvents:UIControlEventValueChanged];
		}
	}
	
	else {
		return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Shit"];
	}
	
	return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 5) {
		UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Pick Any Allergies" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:@"Peanuts", @"Tree Nuts", @"Eggs", @"Wheat", @"Milk", @"Soy", @"Shellfish", @"Fish", nil];
		[sheet showInView:self.view];
	}
	
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    for (int i = 0; i < actionSheet.subviews.count; i++) {
        UIView *v = actionSheet.subviews[i];
        if ([v isKindOfClass:[UIButton class]]) {
			NSString *title = ((UIButton *)v).titleLabel.text;
			 
			if (![title isEqualToString:@"Done"] && [[NSUserDefaults standardUserDefaults] boolForKey:title]) {
				[(UIButton *)v setTitleColor:[UIColor colorWithRed:41/255.0f green:209/255.0f blue:68/255.0f alpha:1.0f] forState:UIControlStateNormal];
            }
        }
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	UIAlertView __block *settingView = [[UIAlertView alloc] initWithTitle:@"Saving..." message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[settingView show];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		[settingView dismissWithClickedButtonIndex:0 animated:YES];
		
		settingView = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your preference change has been saved successfully." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[settingView show];
		
		textField.text = @"";
		[textField resignFirstResponder];
	});
	
	return YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *key = [actionSheet buttonTitleAtIndex:buttonIndex];
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:key];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:key];
}

- (void)switchForVegetarian {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Vegetarian"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Vegetarian"];
}

- (void)switchForVegan {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Vegan"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Vegan"];
}

- (void)switchForPescatarian {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Pescatarian"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Pescatarian"];
}

- (void)switchForLactose {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Lactose"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Lactose"];
}

- (void)switchForGluten {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Gluten"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Gluten"];
}

- (void)switchForKosher {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Kosher"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Kosher"];
}

- (void)switchForHalal {
	BOOL prev = [[NSUserDefaults standardUserDefaults] boolForKey:@"Halal"];
	[[NSUserDefaults standardUserDefaults] setBool:!prev forKey:@"Halal"];
}

@end
