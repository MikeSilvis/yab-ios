//
//  MerchantViewController.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "MerchantViewController.h"

@interface MerchantViewController ()

@end

@implementation MerchantViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadStyles];
}
- (void)loadStyles {
  self.navigationController.topViewController.title = self.merchant.name;
  self.navigationController.navigationBar.tintColor = WHITECOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

@end
