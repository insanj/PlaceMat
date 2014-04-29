//
//  MURJSONValidator.h
//  PlaceMat
//
//  Created by Harlan Haskins on 4/29/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURJSONValidator : NSObject

+ (id) validFieldFromDictionary:(NSDictionary*)dictionary withKey:(id)key;

@end
