//
//  ProfilePhotoView.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfilePhotoView.h"

@implementation ProfilePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)render {

  // Cover Photo
  UIImageView *coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
  if (!![self.coverPhotoUrl host]) {
    [coverPhoto setImageWithURL:self.coverPhotoUrl];
  } else {
    [coverPhoto setImage:[UIImage imageNamed:@"coverDefault"]];
  }
  coverPhoto.contentMode = UIViewContentModeScaleAspectFill;
  coverPhoto.clipsToBounds = YES;
  [self addSubview:coverPhoto];

  UIToolbar *blurToolbar = [[UIToolbar alloc] initWithFrame:coverPhoto.bounds];
  blurToolbar.barStyle = UIBarStyleBlackTranslucent;
  blurToolbar.translucent = YES;
  blurToolbar.alpha = 0.5;
  [coverPhoto addSubview:blurToolbar];
  
  // Profile Photo
  int imageSize = 100;
  UIImageView *profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - imageSize) / 2, (self.frame.size.height - imageSize) / 2, imageSize, imageSize)];
  if (!![self.profilePhotoUrl host]) {
    [profilePhoto setImageWithURL:self.profilePhotoUrl];
  } else {
    [profilePhoto setImage:[UIImage imageNamed:@"blankAvatar"]];
  }
  profilePhoto.layer.borderColor = BLACKCOLOR.CGColor;
  profilePhoto.layer.borderWidth = 3;
  profilePhoto.layer.masksToBounds = YES;
  profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height /2;
  profilePhoto.clipsToBounds = YES;
  [self addSubview:profilePhoto];
}

@end
