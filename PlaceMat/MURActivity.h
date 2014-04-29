//
//  MURActivity.h
//  PlaceMat
//
//  Created by Harlan Haskins on 4/27/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURActivity : NSObject

@property (nonatomic, readonly) NSString *activityDescription;
@property (nonatomic, readonly) NSString *relativeTime;
@property (nonatomic, readonly) NSString *extraInformation;

@property (nonatomic, readonly) NSDate *date;

+ (instancetype) activityFromDictionary:(NSDictionary*)dictionary;

@end
