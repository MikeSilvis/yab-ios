//
//  UIProgressView+Yab.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "UIProgressView+Yab.h"
#import "AppDelegate.h"

@implementation UIProgressView (Yab)
+ (UIProgressView *)defaultStyles:(UIProgressView *)progressView {
  
  progressView.progressTintColor = GREENCOLOR;
  progressView.trackTintColor = WHITECOLOR;

  return progressView;
}
@end
