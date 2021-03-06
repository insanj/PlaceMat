//
//  MURSwitcherButtonItem.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MURSwitcherButton.h"

@interface MURCheckinButtonItem : UIBarButtonItem <UIAlertViewDelegate> {
	UIAlertView *checkInAlert;
	NSString *overrideName;
}

- (instancetype)initWithDefaults;
- (instancetype)initWithName:(NSString *)name;

@end
