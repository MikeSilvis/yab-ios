//
//  LoadingController.m
//  Yab
//
//  Created by Mike Silvis on 4/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "LoadingController.h"

@implementation LoadingController

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  [self findCurrentUser];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}
- (void)findCurrentUser {
}

@end
