//
//  MURBarSwitcherItem.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MURBarSwitcherItem : UIBarButtonItem

@property (nonatomic, retain) NSString *name;

- (instancetype)initWithName:(NSString *)given;

@end
