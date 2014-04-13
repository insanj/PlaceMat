//
//  MURSwitcherButtonItem.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURCheckinButtonItem.h"

@implementation MURCheckinButtonItem

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
	NSLog(@"woo");
}

@end
