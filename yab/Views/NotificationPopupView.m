//
//  NotificationPopup.m
//  Yab
//
//  Created by Mike Silvis on 4/12/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "NotificationPopupView.h"

@implementation NotificationPopupView

- (id)initWithCheckin:(Checkin *)checkin frame:(CGRect)aRect {
  self = [super initWithFrame:aRect];
  self.checkin = checkin;
  
  if (self) {
    [self myInitialization];
  }

  return self;
}

- (void)myInitialization {
  self.opaque = NO;
  self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9f];

  [self.checkin.user updateCurrentUser];
  
  // Close
  UIButton *merchantClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  merchantClose.frame= CGRectMake(0, 20, 50, 50);
  merchantClose.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
  [merchantClose setTitle:@"X" forState:UIControlStateNormal];
  [merchantClose setTitleColor:WHITECOLOR forState:UIControlStateNormal];
  [merchantClose addTarget:self action:@selector(merchantCloseClicked) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:merchantClose];

  // Yabs
  UILabel *points = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 50)];
  points.text = [NSString stringWithFormat:@"%@",self.checkin.level.earned];
  points.textColor = GREENCOLOR;
  points.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
  points.textAlignment = NSTextAlignmentCenter;
  [self addSubview:points];

  // Yabs Earned Label
  UILabel *yabsEarned = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, self.frame.size.width, 50)];
  yabsEarned.text = @"Yabs Earned";
  yabsEarned.textColor = WHITECOLOR;
  yabsEarned.font = [UIFont fontWithName:@"Helvetica" size:16];
  yabsEarned.textAlignment = NSTextAlignmentCenter;
  [self addSubview:yabsEarned];
  
  // Merchant Name
  UILabel *merchantName = [[UILabel alloc] initWithFrame:CGRectMake(105, 250, 200, 50)];
  merchantName.text = self.checkin.merchant.name;
  merchantName.textColor = GREENCOLOR;
  merchantName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
  [self addSubview:merchantName];
  
  // Merchant Text
  UITextView *merchantText = [[UITextView alloc] initWithFrame:CGRectMake(100, 280, 200, 50)];
  merchantText.text = self.checkin.message;
  merchantText.textColor = WHITECOLOR;
  merchantText.editable = false;
  merchantText.backgroundColor = [UIColor clearColor];
  merchantText.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
  [self addSubview:merchantText];
  
  // Merchant Avatar
  UIImageView *merchantAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(30, 270, 50, 50)];
  [merchantAvatar setImageWithURL:self.checkin.merchant.avatarUrl];
  merchantAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
  merchantAvatar.layer.cornerRadius = 25;
  merchantAvatar.layer.masksToBounds = YES;
  merchantAvatar.clipsToBounds = YES;
  merchantAvatar.layer.borderWidth = 2.0;
  [self addSubview:merchantAvatar];
  
  // Progress Bar
  UIProgressView *progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 350, self.frame.size.width, 20)];
  [progressBar setProgress:self.checkin.level.nextLevelPercent animated:YES];
  progressBar.progressTintColor = GREENCOLOR;
  progressBar.trackTintColor = WHITECOLOR;
  [self addSubview:progressBar];
  
  // Share
  UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 260) / 2,(self.frame.size.height - 50),260,40)];
  [shareButton.layer setBackgroundColor:[GREENCOLOR CGColor]];
  [shareButton setTitle:@"SHARE THE NEWS" forState:UIControlStateNormal];
  shareButton.layer.cornerRadius = 10;
  shareButton.layer.masksToBounds = YES;
  shareButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
  [shareButton addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:shareButton];
}
- (void) merchantCloseClicked {
  [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
  [self removeFromSuperview];
}
- (void)shareButtonClicked {
  NSString *textToShare = [NSString stringWithFormat:@"%@ - %@ @getyab", self.checkin.merchant.name, self.checkin.message];
  UIImage *imageToShare = [UIImage imageNamed:@"logo-dark.png"];
  NSArray *itemsToShare = @[textToShare, imageToShare];
  UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
  activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeCopyToPasteboard];
  [self.window.rootViewController presentViewController:activityVC animated:YES completion:nil];
}
@end
