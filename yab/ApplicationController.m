//
//  ApplicationController.m
//  yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ApplicationController.h"
#import "User.h"

@implementation ApplicationController
- (void)viewDidAppear:(BOOL)animated{
  if (![User isLoggedIn]) {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  }
  
}
@end
