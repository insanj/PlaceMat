//
//  MURUser.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURUser : NSObject

@property(nonatomic, retain) NSString *name, *classOf, *checkedIn;
@property(nonatomic, retain) NSMutableArray *activities, *friends, *dishes, *places;
@property(nonatomic, retain) UIImage *avatar;

+ (NSString *)pathForDebugUser;
+ (NSString *)pathForName:(NSString *)name;

- (instancetype)initWithPath:(NSString *)path;

@end
