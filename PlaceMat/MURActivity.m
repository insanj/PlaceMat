//
//  MURActivity.m
//  PlaceMat
//
//  Created by Harlan Haskins on 4/27/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURActivity.h"

@interface MURActivity ()

@property (nonatomic, readwrite) NSString *activityDescription;
@property (nonatomic, readwrite) NSString *relativeTime;

@end

@implementation MURActivity

+ (instancetype) activityFromDictionary:(NSDictionary*)dictionary {
    MURActivity *activity = [MURActivity new];
    activity.activityDescription  = dictionary[@"description"];
    activity.relativeTime = dictionary[@"relativeTime"];
    return activity;
}

@end
