//
//  SecondViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self loadStyles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadStyles {
  self.navigationController.topViewController.title = self.user.name;
}
- (User *)user {
  if (!!_user) {
    return _user;
  } else {
    return [User currentUser];
  }
}

@end
