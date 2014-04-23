//
//  MURBlurView.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

@interface MURBlurView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame inParentView:(UIView *)view;

- (void)applyLightBlur;
- (void)applyDarkBlur;
- (void)applyLightBlurWithRadius:(CGFloat)radius;
- (void)applyDarkBlurWithRadius:(CGFloat)radius;
- (void)applyBlurWithColor:(UIColor *)color andRadius:(CGFloat)radius;

@end
