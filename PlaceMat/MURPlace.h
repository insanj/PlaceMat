//
//  MURPlace.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/18/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURPlace : NSObject

@property (nonatomic, readonly) NSString *name, *money, *serving, *time;
@property (nonatomic, readonly) NSArray *dishes;
@property (nonatomic, readonly) UIImage *avatar;

- (instancetype)initWithName:(NSString *)given;

@end
