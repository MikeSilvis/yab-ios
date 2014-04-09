//
//  SettingsController.m
//  Yab
//
//  Created by Mike Silvis on 3/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "SettingsController.h"
#import "AppDelegate.h"
#import "User.h"

@implementation SettingsController
- (void)viewDidLoad {
  self.navigationController.topViewController.title = @"Settings";
  [self loadStyles];
  [self addFacebookButton];
  [super viewDidLoad];
}
- (void)loadStyles {
  self.navigationController.navigationBar.tintColor = WHITECOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}
- (void)addFacebookButton {
  FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email"]];
  loginView.delegate = self;
  loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 400);
  [self.view addSubview:loginView];
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
  [[User currentUser] logOut];
  [self performSegueWithIdentifier:@"loginSegue" sender:self];
}
@end
