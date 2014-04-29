//
//  MURUser.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURUser.h"
#import "MURActivity.h"
#import "MURJSONValidator.h"

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
	
	NSArray *allUsers = @[[[MURUser alloc] initWithName:@"David"],
						  [[MURUser alloc] initWithName:@"Erin"],
						  [[MURUser alloc] initWithName:@"Regina"],
						  [[MURUser alloc] initWithName:@"Jessica"],
						  [[MURUser alloc] initWithName:@"Joel"]];
	
    NSMutableArray *activities = [NSMutableArray array];
    for (MURUser *user in allUsers) {
        for (MURActivity *activity in user.activities) {
            [activities addObject:activity];
        }
    }
    
    [activities sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 date] compare:[obj2 date]];
    }];
	
	return [NSArray arrayWithArray:activities];
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

- (instancetype) initWithName:(NSString*)name {
    return [self initWithPath:[[self class] pathForName:name]];
}

- (instancetype)initWithPath:(NSString *)path {
	self = [super init];
	if (self) {
		
		NSError *error;
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
        
        NSArray *dictionaries = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                                   withKey:@"activity"];
        self.activities = [self activitiesFromDictionaries:dictionaries];
        
        self.checkedIn = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                            withKey:@"checkedIn"];
        
        self.friends = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                          withKey:@"friends"];
        
        self.dishes = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                         withKey:@"dishes"];
        
        self.places = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                         withKey:@"places"];
        
        self.classOf = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                          withKey:@"class"];
        
        self.name = [MURJSONValidator validFieldFromDictionary:userDictionary
                                                       withKey:@"name"];
		
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
