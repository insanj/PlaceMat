//
//  MURActivity.m
//  PlaceMat
//
//  Created by Harlan Haskins on 4/27/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURActivity.h"
#import "MURJSONValidator.h"

@interface MURActivity ()

@property (nonatomic, readwrite) NSString *activityDescription;
@property (nonatomic, readwrite) NSString *relativeTime;
@property (nonatomic, readwrite) NSString *extraInformation;

@property (nonatomic, readwrite) NSDate *date;

@end

@implementation MURActivity

+ (instancetype) activityFromDictionary:(NSDictionary*)dictionary {
    MURActivity *activity = [MURActivity new];
    activity.activityDescription  = [MURJSONValidator validFieldFromDictionary:dictionary
                                                                       withKey:@"description"];
    
    activity.relativeTime = [MURJSONValidator validFieldFromDictionary:dictionary
                                                               withKey:@"time"];
    
    activity.extraInformation = [MURJSONValidator validFieldFromDictionary:dictionary
                                                                   withKey:@"extra"];
    
    activity.date = [activity dateFromRelativeTime];
    
    return activity;
}

- (NSDate*) dateFromRelativeTime {
    NSString *time = self.relativeTime;
    NSArray *rawTime = [time componentsSeparatedByString:@" "];
    if (rawTime.count < 2) {
        return [NSDate date];
    }
    
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
    return iterated;
}

@end
