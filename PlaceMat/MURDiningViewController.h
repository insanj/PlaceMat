//
//  MURProfileViewController.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURTableViewController.h"
#import "MURPlace.h"

@interface MURDiningViewController : MURTableViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *places, *firstLetters;
}

@end
