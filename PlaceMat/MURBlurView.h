//
//  MURBlurView.h
//  PlaceMat
//
//  Created by Julian Weiss on 4/13/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//
//  Derived from:
//  JCR/AMBlurView.h
//
//  Created by Cesar Pinto Castillo on 7/1/13.
//  Copyright (c) 2013 Arctic Minds Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MURBlurView : UIView

@property (nonatomic, strong) UIColor *blurTintColor;
@property (nonatomic, strong) UIToolbar *toolbar;

- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)radius;

@end
