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
  [super viewDidLoad];
  
  if (![User isLoggedIn]) {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  }
  
}
- (void)viewDidLoad {
  [super viewDidAppear:YES];
  [self loadStyles];
}
- (void)loadStyles {
  [[UITabBar appearance] setTintColor:GREENCOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR
                                                      }
                                           forState:UIControlStateNormal];
  
  self.navigationController.navigationBar.tintColor = BLACKCOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{
                                 NSForegroundColorAttributeName: WHITECOLOR
                                 };

}

@end
