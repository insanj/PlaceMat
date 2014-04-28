//
//  MURUser.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/17/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURUser : NSObject

@property (nonatomic, readonly) NSString *name, *classOf, *checkedIn;
@property (nonatomic, readonly) NSArray *activities, *friends, *dishes, *places;
@property (nonatomic, readonly) UIImage *avatar;

+ (NSArray *)chronologicalListOfUserActivitiesForSocialViewControllerTableViewControllerTableViewCellForRowAtIndexPath;
+ (NSString *)pathForDebugUser;
+ (NSString *)pathForName:(NSString *)name;

- (instancetype)initWithPath:(NSString *)path;

@end
