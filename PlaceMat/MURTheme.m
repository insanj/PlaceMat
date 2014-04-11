//
//  MURTheme.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURTheme.h"

@implementation MURTheme

+ (UIColor *)tintColor {
	return [UIColor colorWithRed:100/255.0 green:157/255.0 blue:213/255.0 alpha:1.0];
}

+ (UIColor *)backgroundColor {
	return [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}

+ (UIColor *)buttonTintColor {
	return [UIColor blackColor];
}

+ (UIColor *)buttonTouchTintColor {
	return [UIColor colorWithWhite:0.9 alpha:0.5];
}

@end
