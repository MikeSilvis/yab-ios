//
//  NotificationPopup.m
//  Yab
//
//  Created by Mike Silvis on 4/12/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "NotificationPopupView.h"

@implementation NotificationPopupView
- (id)initWithFrame:(CGRect)aRect {
  self = [super initWithFrame:aRect];
  
  if (self) {
    [self myInitialization];
  }
  
  return self;
}
- (void)myInitialization {
  self.opaque = NO;
  self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
  
  // Merchant Name
  UILabel *merchantName = [[UILabel alloc] init];
  merchantName.text = @"Pickles";
  merchantName.textColor = GREENCOLOR;
  [merchantName sizeToFit];
  merchantName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
  merchantName.frame = CGRectMake(105, 40, 200, 400);
  [self addSubview:merchantName];
  
  // Merchant Text
  UITextView *merchantText = [[UITextView alloc] init];
  merchantText.text = @"Thanks for coming to Pickles. All well drinks are half off until midnight!";
  merchantText.textColor = WHITECOLOR;
  merchantText.editable = false;
  merchantText.backgroundColor = [UIColor clearColor];
  [merchantText sizeToFit];
  merchantText.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
  merchantText.frame = CGRectMake(100, 250, 200, 400);
  [self addSubview:merchantText];
  
  // Merchant Avatar
  UIImageView *merchantAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pickles"]];
  merchantAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
  merchantAvatar.layer.cornerRadius = merchantAvatar.frame.size.height /2;
  merchantAvatar.layer.masksToBounds = YES;
  merchantAvatar.clipsToBounds = YES;
  merchantAvatar.layer.borderWidth = 2.0;
  merchantAvatar.frame = CGRectMake(30, 240, 50, 50);
  [self addSubview:merchantAvatar];
  
  // Leave a message
  
  // Share
  UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 260) / 2,(self.frame.size.height - 50),260,40)];
  [shareButton.layer setBackgroundColor:[GREENCOLOR CGColor]];
  [shareButton setTitle:@"SHARE THE NEWS" forState:UIControlStateNormal];
  shareButton.layer.cornerRadius = 10;
  shareButton.layer.masksToBounds = YES;
  shareButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
  [shareButton addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:shareButton];
  
  // Close
  UIButton *merchantClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  merchantClose.frame= CGRectMake(0, 20, 50, 50);
  merchantClose.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
  [merchantClose setTitle:@"X" forState:UIControlStateNormal];
  [merchantClose setTitleColor:WHITECOLOR forState:UIControlStateNormal];
  [merchantClose addTarget:self action:@selector(merchantCloseClicked) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:merchantClose];
  
}
- (void) merchantCloseClicked {
  [self removeFromSuperview];
}
- (void)shareButtonClicked {
  NSString *textToShare = @"Come checkout Pickles! @getyab";
  UIImage *imageToShare = [UIImage imageNamed:@"logo-dark.png"];
  NSArray *itemsToShare = @[textToShare, imageToShare];
  UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
  activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeCopyToPasteboard];
  [self.window.rootViewController presentViewController:activityVC animated:YES completion:nil];
}
@end
