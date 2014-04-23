//
//  MURSwitcherButtonItem.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURCheckinButtonItem.h"

@implementation MURCheckinButtonItem

- (instancetype)initWithName:(NSString *)name {
	self = [super initWithCustomView:[[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"CheckIn"]]];
	if (self) {
		overrideName = name;
		[self.button addTarget:self action:@selector(showSpecificCheckIn) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}

- (instancetype)initWithDefaults {
	self = [super initWithCustomView:[[MURSwitcherButton alloc] initWithImage:[UIImage imageNamed:@"CheckIn"]]];
	if (self) {
		[self.button addTarget:self action:@selector(showCheckin) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}

- (MURSwitcherButton *)button {
	return (MURSwitcherButton *)self.customView;
}

- (void)showCheckin {
	checkInAlert = [[UIAlertView alloc] initWithTitle:@"Check in" message:[NSString stringWithFormat:@"Looks like you're near %@. Would you like to share this location?", [self randomPlace]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Share", @"Manual", nil];
	[checkInAlert show];
}

- (void)showSpecificCheckIn {
	checkInAlert = [[UIAlertView alloc] initWithTitle:@"Check in" message:[NSString stringWithFormat:@"Would you like to check in to %@?", overrideName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Share", @"Manual", nil];
	[checkInAlert show];
}

- (NSString *)randomPlace {
	int ran = arc4random_uniform(9);
	switch (ran) {
		default:
		case 0:
			return @"Danforth";
		case 1:
			return @"Douglass";
		case 2:
			return @"Commons";
		case 3:
			return @"Connections";
		case 4:
			return @"Pura Vida";
		case 5:
			return @"Mel Express";
		case 6:
			return @"Hillside";
		case 7:
			return @"Blimpie";
		case 8:
			return @"Starbucks";
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [alertView cancelButtonIndex]) {
		if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Share"]) {
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
				checkInAlert = [[UIAlertView alloc] initWithTitle:@"Checked in" message:@"Thanks for checking in!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[checkInAlert show];
			});
		}
		
		else {
			checkInAlert = [[UIAlertView alloc] initWithTitle:@"Manual" message:@"Custom location name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Share", nil];
			[checkInAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
			[[checkInAlert textFieldAtIndex:0] setPlaceholder:@"e.g. Danforth, Douglass, Commons"];
			[checkInAlert show];
		}
	}
}

@end
