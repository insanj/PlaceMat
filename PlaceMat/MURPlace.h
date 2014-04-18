//
//  MURPlace.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/18/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURPlace : NSObject

@property(nonatomic, retain) NSString *name, *description, *serving, *time;
@property(nonatomic, retain) NSMutableArray *dishes;
@property(nonatomic, retain) UIImage *avatar;

- (instancetype)initWithName:(NSString *)given;

@end
