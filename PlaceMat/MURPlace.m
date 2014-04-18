//
//  MURPlace.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/18/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURPlace.h"

@implementation MURPlace

- (instancetype)initWithName:(NSString *)given {
	self = [super init];
	if (self) {
		_dishes = [[NSMutableArray alloc] init];
		
		NSError *error;
		NSString *raw = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:given ofType:@"txt"]
 encoding:NSUTF8StringEncoding error:&error];
		
		NSArray *lines = [raw componentsSeparatedByString:@"\n"];
		for (NSString *line in lines) {
			NSArray *components = [line componentsSeparatedByString:@" = "];
			NSString *key = components[0];
			NSString *val = components[1];
			
			if ([key isEqualToString:@"name"]) {
				_name = val;
			}
			
			else if ([key isEqualToString:@"money"]) {
				_description = val;
			}
			
			else if ([key isEqualToString:@"serving"]) {
				_serving = val;
			}
			
			else if ([key isEqualToString:@"time"]) {
				_time = val;
			}
			
			else if ([key rangeOfString:@"Dish "].location != NSNotFound) {
				[_dishes addObject:val];
			}
		}
		
		_avatar = [UIImage imageNamed:given];
	}
	
//	NSLog(@"Created new Place with name:%@, description:%@, serving:%@, time:%@, dishes:%@, avatar:%@", _name, _description, _serving, _time, _dishes, _avatar);
	
	return self;
}

@end


/*

 name = Danforth
 money = unlimited, declining ($7.50)
 serving = lunch
 time = 11:00 - 13:30
 Dish 1 = Southwest Sweet Potatoes; v; gf
 Dish 2 = Chicken Quesadillas
 Dish 3 = Egg Salsa Burrito; v
 Dish 4 = Vegetarian Parmesan Wheat Pita; vin
 Dish 5 = California Turkey Sandwich

*/