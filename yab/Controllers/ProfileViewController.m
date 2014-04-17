//
//  SecondViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "UIImage+Yab.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Me";
    [self loadStyles];
    [self loadLevel];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self loadImages];
}

- (User *)user {
  if (!!_user) {
    return _user;
  } else {
    return [User currentUser];
  }
}
- (void)loadStyles {
  FAKFontAwesome *cogIcon = [FAKFontAwesome cogIconWithSize:2];
  [cogIcon addAttribute:NSForegroundColorAttributeName value:WHITECOLOR];
  cogIcon.iconFontSize = 20;
  self.settingsGear.image = [cogIcon imageWithSize:CGSizeMake(30, 30)];

  // Navigation
  [self preferredStatusBarStyle];
  self.navigationController.navigationBar.barTintColor = BLACKCOLOR;
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.titleTextAttributes = @{
                                                                  NSForegroundColorAttributeName: WHITECOLOR
                                                                  };
  UIToolbar *blurToolbar = [[UIToolbar alloc] initWithFrame:self.coverPhotoUrl.bounds];
  blurToolbar.barStyle = UIBarStyleBlackTranslucent;
  blurToolbar.translucent = YES;
  blurToolbar.alpha = 0.5;
  [self.coverPhotoUrl addSubview:blurToolbar];
  
  // Achievements Bar
  self.achievementsBar.backgroundColor = BLACKCOLOR;
  self.achievementsBar.translucent = NO;
  [[UITabBar appearance] setSelectedImageTintColor:WHITECOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:10.0f]
                                                      }
                                           forState:UIControlStateNormal];
}
- (void)loadImages {
  // Profile Photo
  if (!![self.user.profilePhotoUrl length]) {
    NSURL *profileUrl = [NSURL URLWithString:self.user.profilePhotoUrl];
    [self.profilePhotoUrl setImageWithURL:profileUrl];
  }
  self.profilePhotoUrl.layer.borderColor = BLACKCOLOR.CGColor;
  self.profilePhotoUrl.layer.borderWidth = 3;
  self.profilePhotoUrl.layer.masksToBounds = YES;
  self.profilePhotoUrl.layer.cornerRadius = self.profilePhotoUrl.frame.size.height /2;
  self.profilePhotoUrl.clipsToBounds = YES;

  // Cover Photo
  if (!![self.user.coverPhotoUrl length]) {
    NSURL *coverUrl = [NSURL URLWithString:self.user.coverPhotoUrl];
    [self.coverPhotoUrl setImageWithURL:coverUrl];
  } else {
    [self.coverPhotoUrl setImage:[UIImage imageNamed:@"coverDefault"]];
  }
}
- (void)loadLevel {
  [self.achievementsBar.items[1] setTitle:self.user.levelName];
  NSURL *url = [NSURL URLWithString:self.user.levelIconUrl];
  UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
  [self.achievementsBar.items[1] setFinishedSelectedImage:img
                              withFinishedUnselectedImage:img
   ];
  
  UIImage *customTextImage = [[UIImage drawText:self.user.yabs
                                       inImage:[UIImage imageNamed:@"yabs"]
                                       atPoint:CGPointMake(0, 0)]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

  [self.achievementsBar.items[0] setFinishedSelectedImage:customTextImage
                              withFinishedUnselectedImage:customTextImage
   ];

}

- (IBAction)settingsGearTouched:(id)sender {
  [self performSegueWithIdentifier:@"settingsModal" sender:self];
}
@end
