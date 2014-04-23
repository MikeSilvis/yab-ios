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
    [self loadLevel];
    [self loadStyles];
    [self loadImages];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
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
  if (!![self.user.profilePhotoUrl host]) {
    [self.profilePhotoUrl setImageWithURL:self.user.profilePhotoUrl];
  } else {
    [self.profilePhotoUrl setImage:[UIImage imageNamed:@"blankAvatar"]];
  }

  self.profilePhotoUrl.layer.borderColor = BLACKCOLOR.CGColor;
  self.profilePhotoUrl.layer.borderWidth = 3;
  self.profilePhotoUrl.layer.masksToBounds = YES;
  self.profilePhotoUrl.layer.cornerRadius = self.profilePhotoUrl.frame.size.height /2;
  self.profilePhotoUrl.clipsToBounds = YES;

  // Cover Photo
  if (!![self.user.profilePhotoUrl host]) {
    [self.coverPhotoUrl setImageWithURL:self.user.coverPhotoUrl];
  } else {
    [self.coverPhotoUrl setImage:[UIImage imageNamed:@"coverDefault"]];
  }
}
- (void)loadLevel {
  dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:self.user.levelIconUrl] scale:[[UIScreen mainScreen] scale]];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.achievementsBar.items[1] setFinishedSelectedImage:img
                                  withFinishedUnselectedImage:img
       ];
    });

  });
  
  [self.achievementsBar.items[1] setTitle:self.user.levelName];
  
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
