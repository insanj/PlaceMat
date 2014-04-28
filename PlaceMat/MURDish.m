//
//  MURDish.m
//  PlaceMat
//
//  Created by Harlan Haskins on 4/27/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURDish.h"

@interface MURDish ()

@property (nonatomic, readwrite) BOOL vegan;
@property (nonatomic, readwrite) BOOL vegetarian;
@property (nonatomic, readwrite) BOOL glutenFree;

@property (nonatomic, readwrite) UIImage *thumbnail;

@end

@implementation MURDish

+ (instancetype) dishWithDictionary:(NSDictionary*) dictionary {
    MURDish *dish = [MURDish new];
    dish.name = dictionary[@"name"];
    dish.vegan = [dictionary[@"vegan"] boolValue];
    
    // If the dish is vegan, the dish is by definition also vegetarian.
    dish.vegetarian = dish.vegan ? YES : [dictionary[@"vegetarian"] boolValue];
    
    dish.glutenFree = [dictionary[@"gluten-free"] boolValue];
    
    dish.thumbnail = [UIImage imageNamed:dish.name];
    
    return dish;
}

- (NSString*) descriptionWithFoodTypes {
    NSString *food = self.name;
    
    if (self.vegan) {
        food = [food stringByAppendingString:@"*"];
    }
    // This needs to be an else-if, because vegetarian is implied by vegan.
    else if (self.vegetarian) {
        food = [food stringByAppendingString:@"✭"];
    }
    if (self.glutenFree) {
        food = [food stringByAppendingString:@"✝"];
    }
    
    return food;
}

@end
