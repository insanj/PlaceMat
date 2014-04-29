//
//  MURJSONValidator.m
//  PlaceMat
//
//  Created by Harlan Haskins on 4/29/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURJSONValidator.h"

@implementation MURJSONValidator

+ (id) validFieldFromDictionary:(NSDictionary*)dictionary withKey:(id)key {
    id object = dictionary[key];
    if (!object || object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end
