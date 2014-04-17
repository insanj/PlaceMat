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
	return [[NSBundle mainBundle] pathForResource:@"Erin" ofType:@"txt"];
}

- (instancetype)initWithPath:(NSString *)path {
	self = [super init];
	if (self) {
		_activities = [[NSMutableArray alloc] init];
		_friends = [[NSMutableArray alloc] init];
		_dishes = [[NSMutableArray alloc] init];
		
		NSError *error;
		NSString *raw = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
		
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
		
		_avatar = [UIImage imageNamed:[path substringWithRange:NSMakeRange(0, path.length - 4)]];
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
