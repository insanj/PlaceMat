//
//  MURBlurView.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURBlurView.h"

@implementation MURBlurView {
	UIView *parentView;
}

- (instancetype)initWithFrame:(CGRect)frame inParentView:(UIView *)view {
	self = [super initWithFrame:frame];
	
	if (self) {
		self.contentMode = UIViewContentModeCenter;
		self.userInteractionEnabled = NO;
		parentView = view;
	}
	
	return self;
}

- (void)applyLightBlur {
	UIGraphicsBeginImageContext(self.frame.size);
	[parentView drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.image = [image applyLightEffect];
}

- (void)applyDarkBlur {
	UIGraphicsBeginImageContext(self.frame.size);
	[parentView drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.image = [image applyDarkEffect];
}

- (void)applyLightBlurWithRadius:(CGFloat)radius {
	UIGraphicsBeginImageContext(self.frame.size);
	[parentView drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.image = [image applyBlurWithRadius:radius tintColor:[UIColor colorWithWhite:1.0 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
}

- (void)applyDarkBlurWithRadius:(CGFloat)radius {
	UIGraphicsBeginImageContext(self.frame.size);
	[parentView drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.image = [image applyBlurWithRadius:radius tintColor:[UIColor colorWithWhite:0.11 alpha:0.73] saturationDeltaFactor:1.8 maskImage:nil];
}

- (void)applyBlurWithColor:(UIColor *)color andRadius:(CGFloat)radius {
	UIGraphicsBeginImageContext(self.frame.size);
	[parentView drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.image = [image applyBlurWithRadius:radius tintColor:color saturationDeltaFactor:1.8 maskImage:nil];
}

@end
