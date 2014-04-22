//
//  MURSettingsViewController.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURTableViewController.h"

@interface MURSettingsViewController : MURTableViewController  <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, retain) NSDictionary *specifiers;
@property(nonatomic, retain) NSArray *cells;

@end
