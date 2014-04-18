//
//  MURUser.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURUser.h"

@implementation MURUser

+ (NSString *)pathForDebugUser {
	int ran = arc4random_uniform(6);
	NSString *name;
	switch (ran) {
		default:
		case 0:
			name = @"David";
			break;
		case 1:
			name = @"Erin";
			break;
		case 2:
			name = @"Regina";
			break;
		case 3:
			name = @"Cam";
			break;
		case 4:
			name = @"Jessica";
			break;
		case 5:
			name = @"Joel";
			break;
	}
	
	return [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
}

- (instancetype)initWithPath:(NSString *)path {
	self = [super init];
	if (self) {
		_activities = [[NSMutableArray alloc] init];
		_friends = [[NSMutableArray alloc] init];
		_dishes = [[NSMutableArray alloc] init];
		
		NSError *error;
		NSString *raw = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
		
		NSArray *lines = [raw componentsSeparatedByString:@"\n"];
		for (NSString *line in lines) {
			NSArray *components = [line componentsSeparatedByString:@" = "];
			NSString *key = components[0];
			NSString *val = components[1];
			
			if ([key isEqualToString:@"name"]) {
				_name = val;
			}
			
			else if ([key isEqualToString:@"class"]) {
				_classOf = val;
			}
			
			else if ([key isEqualToString:@"checked in"]) {
				_checkedIn = val;
			}
			
			else if ([key rangeOfString:@"Activity "].location != NSNotFound) {
				[_activities addObject:val];
			}
			
			else if ([key rangeOfString:@"Friend "].location != NSNotFound) {
				[_friends addObject:val];
			}
			
			else if ([key rangeOfString:@"Dish "].location != NSNotFound) {
				[_dishes addObject:val];
			}
		}
		
		NSString *imagePath = [[path substringWithRange:NSMakeRange(0, path.length - 4)] stringByAppendingString:@".png"];
		_avatar = [UIImage imageWithContentsOfFile:imagePath];
	}
	
	return self;
}

@end

/*
 name = Erin Cherry
 class = PD Associate
 checked in =
 Activity 1 = Said: "Dinner with Louise Lu Yi was delicious"; 12 hr
 Activity 2 = Rated Meat Lover's Calzone; ****
 Activity 3 = Checked into Douglass; 12 hr
 Activity 4 = Maggie Curtis forked Erin
 Activity 5 = Checked into The Commons; 17 hr
 Friend 1 = Maggie Curtis
 Friend 2 = Julian Weiss
 Friend 3 = Jessica Sheng
 Friend 4 = David Libbey
 Friend 5 = Louis Lu Yi*/
