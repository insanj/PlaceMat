//
//  MURProfileViewController.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURTableViewController.h"
#import "MURUser.h"

@interface MURProfileViewController : MURTableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) MURUser *user;
@property(nonatomic, retain) NSString *name;

@end
