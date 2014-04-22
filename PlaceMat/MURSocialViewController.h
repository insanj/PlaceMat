//
//  MURSocialViewController.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURTableViewController.h"
#import "MURUser.h"

@interface MURSocialViewController : MURTableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) NSArray *activity;

@end
