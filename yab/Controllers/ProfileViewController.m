//
//  SecondViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "UIImage+BlurAndDarken.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Me";
    [self loadStyles];
    [self loadImages];
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
  // Achievements Bar
  self.achievementsBar.backgroundColor = BLACKCOLOR;
  self.achievementsBar.translucent = NO;
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14.0f]
                                                      }
                                           forState:UIControlStateNormal];
}
- (void)loadImages {
  // Profile Photo
  NSURL *profileUrl = [NSURL URLWithString:self.user.profilePhotoUrl];
  [self.profilePhotoUrl setImageWithURL:profileUrl];
  self.profilePhotoUrl.layer.borderColor = BLACKCOLOR.CGColor;
  self.profilePhotoUrl.layer.borderWidth = 3;
  self.profilePhotoUrl.layer.masksToBounds = YES;
  self.profilePhotoUrl.layer.cornerRadius = self.profilePhotoUrl.frame.size.height /2;
  self.profilePhotoUrl.clipsToBounds = YES;

  // Cover Photo
  NSURL *coverUrl = [NSURL URLWithString:self.user.coverPhotoUrl];
  NSData *coverData = [NSData dataWithContentsOfURL:coverUrl];
  UIImage *coverImg = [[UIImage alloc] initWithData:coverData];
  self.coverPhotoUrl.image = coverImg;

  // Blur Photo
  __weak ProfileViewController *weakSelf = self;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
    UIImage *image = [weakSelf.coverPhotoUrl.image darkened:0.5f andBlurredImage:3.0f blendModeFilterName:@"CIMultiplyBlendMode"];

    __weak ProfileViewController *innerSelf = weakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
      innerSelf.coverPhotoUrl.image = image;
    });
  });
  
}

- (IBAction)settingsGearTouched:(id)sender {
  [self performSegueWithIdentifier:@"settingsModal" sender:self];
}
@end
