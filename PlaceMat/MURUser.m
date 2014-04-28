//
//  MURUser.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURUser.h"
#import "MURActivity.h"

@interface MURUser ()

@property (nonatomic, readwrite) NSString *name, *classOf, *checkedIn;
@property (nonatomic, readwrite) NSArray *activities, *friends, *dishes, *places;
@property (nonatomic, readwrite) UIImage *avatar;

@end

@implementation MURUser

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
	/*int ran = arc4random_uniform(5);
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
	}*/
	
	return [[NSBundle mainBundle] pathForResource:@"Erin" ofType:@"json"];
}


+ (NSString *)pathForName:(NSString *)name {
	return [[NSBundle mainBundle] pathForResource:[name componentsSeparatedByString:@" "][0] ofType:@"json"];
}

- (instancetype)initWithPath:(NSString *)path {
	self = [super init];
	if (self) {
		
		NSError *error;
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
        NSArray *dictionaries = userDictionary[@"activity"];
        self.activities = [self activitiesFromDictionaries:dictionaries];
        self.checkedIn = userDictionary[@"checkedIn"];
        self.friends = userDictionary[@"friends"];
        self.dishes = userDictionary[@"dishes"];
        self.places = userDictionary[@"places"];
        self.classOf = userDictionary[@"class"];
        self.name = userDictionary[@"name"];
		
		NSString *imagePath = [path stringByReplacingOccurrencesOfString:@".json" withString:@".png"];
		self.avatar = [UIImage imageWithContentsOfFile:imagePath];
	}
	
	return self;
}

- (NSArray*) activitiesFromDictionaries:(NSArray*)dictionaries {
    NSMutableArray *activities = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        MURActivity *activity = [MURActivity activityFromDictionary:dictionary];
        [activities addObject:activity];
    }
    return activities;
}

@end
