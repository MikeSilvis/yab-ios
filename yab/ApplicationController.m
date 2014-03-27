//
//  ApplicationController.m
//  yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ApplicationController.h"
#import "AppDelegate.h"
#import "User.h"
#import "UINavigationBar+Yab.h"

@implementation ApplicationController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  [[[RKObjectManager sharedManager] HTTPClient] setAuthorizationHeaderWithToken:@"hello"];

  if (![User isLoggedIn]) {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  }
  
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadStyles];
}
- (void)loadStyles {
  [[UIBarButtonItem appearance] setTintColor:WHITECOLOR];
  [[UITabBar appearance] setTintColor:GREENCOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:10.0f]
                                                      }
                                           forState:UIControlStateNormal];
}

@end
