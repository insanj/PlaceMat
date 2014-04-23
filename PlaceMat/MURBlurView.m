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
		self.layer.masksToBounds = YES;
		// self.layer.rasterizationScale = 0.25;
		// self.layer.shouldRasterize = YES;
		self.userInteractionEnabled = NO;

		[self setup];
    }
	
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)radius {
	if ((self = [super initWithFrame:frame])){
		self.clipsToBounds = YES;
		self.layer.masksToBounds = YES;
		self.layer.cornerRadius = radius;
		self.userInteractionEnabled = NO;

		[self setup];
	}
	
    return self;
}

- (void)setup {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        _toolbar.translatesAutoresizingMaskIntoConstraints = NO;
        [self insertSubview:_toolbar atIndex:0];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolbar]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_toolbar)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_toolbar]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_toolbar)]];
    }
}

- (void)setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

@end