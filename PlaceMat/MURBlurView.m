//
//  MURBlurView.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURBlurView.h"

@implementation MURBlurView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])){
		self.clipsToBounds = YES;
		
		UIToolbar *blurBar = [[UIToolbar alloc] initWithFrame:frame];
		blurBar.translatesAutoresizingMaskIntoConstraints = NO;
		self.toolbar = blurBar;
		
		[self insertSubview:self.toolbar atIndex:0];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolbar]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolbar)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_toolbar]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolbar)]];
    }
	
    return self;
}

- (void)setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

@end