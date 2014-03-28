//
//  MURBarSwitcherItem.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURBarSwitcherItem.h"

@implementation MURBarSwitcherItem

- (instancetype)initWithName:(NSString *)given {
	self = [super initWithImage:[UIImage imageNamed:given] style:UIBarButtonItemStylePlain target:self action:@selector(wasTapped)];
	return self;
}

- (void)wasTapped {
	NSLog(@"wasTapped!");
}


@end
