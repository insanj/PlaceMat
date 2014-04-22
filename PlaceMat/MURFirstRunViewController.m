//
//  MURFirstRunViewController.m
//  PlaceMat
//
//  Created by Julian Weiss on 4/21/14.
//  Copyright (c) 2014 MonicUR. All rights reserved.
//

#import "MURFirstRunViewController.h"

@implementation MURFirstRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"PlaceMat";
	self.view.backgroundColor = [MURTheme backgroundColor];
	
	CGFloat padding = 20.0;
	UILabel *welcome = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
	welcome.center = CGPointMake(self.view.center.x, self.view.center.y - welcome.frame.size.height - padding);
	welcome.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0];
	welcome.textAlignment = NSTextAlignmentCenter;
	welcome.textColor = [UIColor blackColor];
	welcome.text = @"Welcome";
	
	UILabel *glad = [[UILabel alloc] initWithFrame:CGRectMake(0.0, welcome.frame.origin.y + welcome.frame.size.height - (padding / 3.0), self.view.frame.size.width, 50.0)];
	glad.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
	glad.textAlignment = NSTextAlignmentCenter;
	glad.textColor = [UIColor darkTextColor];
	glad.text = @"We're glad to feed you.\nPlease create an account or log in below.";
	glad.numberOfLines = 0;
	
	UIButton *createAccount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[createAccount addTarget:self action:@selector(resignFirstRunView) forControlEvents:UIControlEventTouchUpInside];
	[createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
	createAccount.titleLabel.font = [UIFont systemFontOfSize:20.0];
	createAccount.frame = glad.frame;
	createAccount.center = CGPointMake(createAccount.center.x, (glad.center.y + (glad.frame.size.height / 2.0)) + (padding * 2.0));

	UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[login addTarget:self action:@selector(resignFirstRunView) forControlEvents:UIControlEventTouchUpInside];
	[login setTitle:@"Log in" forState:UIControlStateNormal];
	login.titleLabel.font = [UIFont systemFontOfSize:20.0];
	login.frame = glad.frame;
	login.center = CGPointMake(login.center.x, (createAccount.center.y + (createAccount.frame.size.height / 2.0)) + (padding / 1.4));
	
	UIButton *facebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[facebook addTarget:self action:@selector(resignFirstRunView) forControlEvents:UIControlEventTouchUpInside];
	[facebook setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
	facebook.titleLabel.font = [UIFont systemFontOfSize:20.0];
	facebook.frame = login.frame;
	facebook.center = CGPointMake(facebook.center.x, (login.center.y + (login.frame.size.height / 2.0)) + (padding / 1.4));
	
	[self.view addSubview:welcome];
	[self.view addSubview:glad];
	[self.view addSubview:createAccount];
	[self.view addSubview:login];
	[self.view addSubview:facebook];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController.navigationBar.topItem setHidesBackButton:YES animated:NO];
	[super viewWillAppear:animated];
}

- (void)resignFirstRunView {
	[self.navigationController popToRootViewControllerAnimated:YES];
	[self.navigationController.navigationBar.topItem setHidesBackButton:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
