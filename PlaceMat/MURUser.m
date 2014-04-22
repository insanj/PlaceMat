//
//  MURUser.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURUser.h"

@implementation MURUser

/*
 
 Activity 1 = David checked into Danforth; 10 min
 Activity 2 = Maggie Curtis spooned David; 5 hr
 
 */

+ (NSArray *)chronologicalListOfUserActivitiesForSocialViewControllerTableViewControllerTableViewCellForRowAtIndexPath {
	
	/*NSMutableArray *runningUsers = [[NSMutableArray alloc] init];
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSLog(@"path :%@", path);
	for(NSString *pathName in [manager contentsOfDirectoryAtPath:path error:&error]) {
		NSLog(@"pathName: %@", pathName);
		if ([pathName rangeOfString:@"txt"].location != NSNotFound) {
			MURUser *user = [[MURUser alloc] initWithPath:[path stringByAppendingString:pathName]];
			NSLog(@"adding: %@", user);
			[runningUsers addObject:user];
		}
	}*/
	
	NSArray *allUsers = @[[[MURUser alloc] initWithPath:[MURUser pathForName:@"David"]],
						  [[MURUser alloc] initWithPath:[MURUser pathForName:@"Erin"]],
						  [[MURUser alloc] initWithPath:[MURUser pathForName:@"Regina"]],
						  [[MURUser alloc] initWithPath:[MURUser pathForName:@"Jessica"]],
						  [[MURUser alloc] initWithPath:[MURUser pathForName:@"Joel"]]];
	NSMutableDictionary *datesToActivities = [[NSMutableDictionary alloc] init];
	
	//; 1 min
	for (MURUser *user in allUsers) {
		for (NSString *rawActivity in user.activities) {
			NSArray *split = [rawActivity componentsSeparatedByString:@"; "];
			
			NSArray *rawTime = [split[1] componentsSeparatedByString:@" "];
			if (rawTime.count == 2) {
				CGFloat minutes;
				if ([rawTime[1] rangeOfString:@"min"].location == NSNotFound) {
					minutes = [rawTime[0] floatValue] * 60;
				}
				
				else {
					minutes = [rawTime[0] floatValue];
				}
				
				NSDateComponents *add = [[NSDateComponents alloc] init];
				add.minute = minutes;
				
				NSDate *iterated = [[NSCalendar currentCalendar] dateByAddingComponents:add toDate:[NSDate date] options:0];
				[datesToActivities setObject:rawActivity forKey:iterated];
			}
		}
	}
	
	NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
	NSArray *descriptors = [NSArray arrayWithObject:descriptor];
	NSArray *reverseOrder = [datesToActivities.allKeys sortedArrayUsingDescriptors:descriptors];
	
	NSMutableArray *ranAround = [[NSMutableArray alloc] init];
	for (int i = ((int)reverseOrder.count)-1; i >= 0; i--) {
		[ranAround addObject:[datesToActivities objectForKey:reverseOrder[i]]];
	}
	
	return [NSArray arrayWithArray:ranAround];
}

+ (NSString *)pathForDebugUser {
	int ran = arc4random_uniform(5);
	NSString *name;
	switch (ran) {
		default:
		case 0:
			name = @"Erin";
			break;
		case 1:
			name = @"David";
			break;
		case 2:
			name = @"Jessica";
			break;
		case 3:
			name = @"Regina";
			break;
		case 4:
			name = @"Joel";
			break;
	}
	
	return [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
}


+ (NSString *)pathForName:(NSString *)name {
	return [[NSBundle mainBundle] pathForResource:[name componentsSeparatedByString:@" "][0] ofType:@"txt"];
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
