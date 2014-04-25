//
//  MerchantViewController.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "MerchantViewController.h"
#import "ProfilePhotoView.h"
#import "LevelView.h"
#import "ProfileViewController.h"
#import "DefaultTable.h"

@interface MerchantViewController ()

@end

@implementation MerchantViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadStyles];
  [self loadViews];
}

- (void)loadStyles {
  self.navigationController.topViewController.title = self.merchant.name;
  self.navigationController.navigationBar.tintColor = WHITECOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
  self.view.backgroundColor = WHITECOLOR;
}

- (void)loadViews {
  ProfilePhotoView *photoView = [[ProfilePhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 153)];
  photoView.profilePhotoUrl = self.merchant.avatarUrl;
//  photoView.coverPhotoUrl   = self.merchant.coverPhotoUrl;
  [photoView render];
  [self.view addSubview:photoView];
  
  LevelView *levelView = [[LevelView alloc] initWithFrame:CGRectMake(0, 153, self.view.frame.size.width, 50)];
  levelView.iconUrl = self.merchant.overall_level.iconUrl;
  levelView.points  = self.merchant.overall_level.points;
  levelView.name    = self.merchant.overall_level.name;
  [levelView render];
  [self.view addSubview:levelView];
  
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushSegue:) name:@"selectedRow" object:nil];
  DefaultTable *defaultTable = [[DefaultTable alloc] initWithFrame:CGRectMake(0, 202, self.view.frame.size.width, 300)];
  defaultTable.objects = self.merchant.rewards;
  defaultTable.tableLabel = @"Rewards";
  defaultTable.merchantPoints = [self.merchant.user_level.points floatValue];
  [defaultTable render];
  defaultTable.defaultTable.allowsSelection = NO;
  [self.view addSubview:defaultTable];
}

//- (void)pushSegue:(NSNotification *)notification {
//  self.userToPush = notification.object;
//  [self performSegueWithIdentifier:@"userSegue" sender:self];
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  if([segue.identifier isEqualToString:@"userSegue"]) {
//    ProfileViewController *destViewController = segue.destinationViewController;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedRow" object:nil];
//    destViewController.user = self.userToPush;
//  }
//}
@end
