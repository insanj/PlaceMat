//
//  MURSwitcherButton.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/11/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURSwitcherButton.h"

#define DEFAULT_IMAGE_SIZE (CGSize){33.0, 33.0}

@implementation MURSwitcherButton

-(instancetype)initWithImage:(UIImage *)image {
	UIImage *sized = [self sizeImageToDefault:image];
	
	if ((self = [super initWithFrame:CGRectMake(0.0, 0.0, sized.size.width + 5.0, sized.size.height + 5.0)])) {
		[self setImage:sized forState:UIControlStateNormal];
		self.contentMode = UIViewContentModeCenter;
	}
	
	return self;
}

// Dim the button to simulate stock Apple goodness
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[UIView animateWithDuration:0.1 animations:^(void){
		self.alpha = 0.4;
	}];
	
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[UIView animateWithDuration:0.5 animations:^(void){
		self.alpha = 1.0;
	}];
	[super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[UIView animateWithDuration:0.5 animations:^(void){
		self.alpha = 1.0;
	}];
	[super touchesEnded:touches withEvent:event];
}

- (UIImage *)sizeImageToDefault:(UIImage *)image {
	UIGraphicsBeginImageContextWithOptions(DEFAULT_IMAGE_SIZE, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, DEFAULT_IMAGE_SIZE.width, DEFAULT_IMAGE_SIZE.height)];
    UIImage *sized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return sized;
}

@end
