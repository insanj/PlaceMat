//
//  MURDish.h
//  PlaceMat
//
//  Created by Harlan Haskins on 4/27/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURDish : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic, readonly) BOOL vegan;
@property (nonatomic, readonly) BOOL vegetarian;
@property (nonatomic, readonly) BOOL glutenFree;

@property (nonatomic, readonly) UIImage *thumbnail;

+ (instancetype) dishWithDictionary:(NSDictionary*) dictionary;
- (NSString*) descriptionWithFoodTypes;

@end
