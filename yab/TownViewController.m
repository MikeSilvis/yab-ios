//
//  FirstViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "TownViewController.h"

@interface TownViewController ()

@end

@implementation TownViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:YES];
  [self loadStyles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)loadStyles {
    self.navigationController.topViewController.title = @"Penn State";
}

@end
