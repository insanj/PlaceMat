//
//  MURTheme.m
//  PlaceMat
//
//  Created by Julian Weiss on 3/28/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURTheme.h"

@implementation MURTheme

+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size{
	UIGraphicsBeginImageContextWithOptions(size, YES, 0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color setFill];
	CGContextFillRect(context, (CGRect){(CGPoint){0.0, 0.0}, size});
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

+ (UIColor *)tintColor {
	return [UIColor whiteColor];
}

+ (UIColor *)barTintColor {
	return [UIColor colorWithRed:100/255.0 green:157/255.0 blue:213/255.0 alpha:1.0];
}

+ (UIColor *)backgroundColor {
	return [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}

+ (UIColor *)buttonTintColor {
	return [UIColor whiteColor];
}

+ (UIColor *)buttonTouchTintColor {
	return [UIColor colorWithWhite:0.9 alpha:0.5];
}

@end
