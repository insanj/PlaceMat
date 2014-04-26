//
//  MURTheme.h
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MURTheme : NSObject

+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;

// Main tint colors for app. Used in NavigationBars.
+ (UIColor *)tintColor;
+ (UIColor *)barTintColor;

// Main background color for app. Used in ViewControllers.
+ (UIColor *)backgroundColor;

// UIButton tint colors (MURSwitcherButton is primary usage), unused
// + (UIColor *)buttonTintColor;
// + (UIColor *)buttonTouchTintColor;

@end
