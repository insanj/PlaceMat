//
//  MURPlace.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/18/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURPlace.h"
#import "MURDish.h"

@interface MURPlace ()

@property (nonatomic, readwrite) NSString *name, *money, *serving, *time;
@property (nonatomic, readwrite) NSArray *dishes;
@property (nonatomic, readwrite) UIImage *avatar;

@end

@implementation MURPlace

- (instancetype)initWithName:(NSString *)given {
	self = [super init];
	if (self) {
		_dishes = [[NSMutableArray alloc] init];
		
		NSError *error;
		NSString *file = [[NSBundle mainBundle] pathForResource:given ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:file];
        
        NSDictionary *placeDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:NSJSONReadingAllowFragments
                                                                          error:&error];

        
        self.name = placeDictionary[@"name"];
        self.money = placeDictionary[@"money"];
        self.serving = placeDictionary[@"serving"];
        self.time = placeDictionary[@"time"];
        
        NSArray *dishDictionaries = placeDictionary[@"dishes"];
        self.dishes = [self dishesFromDictionaryArray:dishDictionaries];
		
		self.avatar = [UIImage imageNamed:given];
	}
	
//	NSLog(@"Created new Place with name:%@, description:%@, serving:%@, time:%@, dishes:%@, avatar:%@", _name, _description, _serving, _time, _dishes, _avatar);
	
	return self;
}

- (NSArray*) dishesFromDictionaryArray:(NSArray*)array {
    NSMutableArray *dishes = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        MURDish *dish = [MURDish dishWithDictionary:dictionary];
        [dishes addObject:dish];
    }
    return dishes;
}

@end
