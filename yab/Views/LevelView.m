//
//  LevelView.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "LevelView.h"
#import "AppDelegate.h"
#import "UIImage+Yab.h"

@implementation LevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
- (void)render {
  // Achievements Bar
  UITabBar *achievementsBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
  achievementsBar.backgroundColor = BLACKCOLOR;
  achievementsBar.translucent = NO;
  achievementsBar.barTintColor = BLACKCOLOR;
  [[UITabBar appearance] setSelectedImageTintColor:WHITECOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:10.0f]
                                                      }
                                           forState:UIControlStateNormal];
  
  UIImage *customTextImage = [[UIImage drawText:[self.points stringValue]
                                        inImage:[UIImage imageNamed:@"yabs"]
                                        atPoint:CGPointMake(0, 0)]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
  UITabBarItem *yabs = [[UITabBarItem alloc] initWithTitle:@"Yabs"
                                                          image:customTextImage
                                                  selectedImage:customTextImage];
  
  UITabBarItem *level = [[UITabBarItem alloc] initWithTitle:self.name
                                                          image:[UIImage imageNamed:@"yabs"]
                                                  selectedImage:[UIImage imageNamed:@"yabs"]];
  
  NSArray *itemsArray = [NSArray arrayWithObjects:yabs,level, nil];
  
  [achievementsBar setItems:itemsArray animated:NO];

  [self addSubview:achievementsBar];
  
  UIImageView *iconUrl = [[UIImageView alloc] initWithFrame:CGRectMake(230, 8, 20, 20)];
  [iconUrl setImageWithURL:self.iconUrl];
  [self addSubview:iconUrl];
}

@end
