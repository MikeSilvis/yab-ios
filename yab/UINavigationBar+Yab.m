//
//  UINavigationItem+Yab.m
//  Yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "UINavigationBar+Yab.h"

@implementation UINavigationBar (Yab)
+ (UINavigationBar *)defaultStyles:(UINavigationBar *)navBar {
  navBar.barTintColor = [UIColor blackColor];
  navBar.titleTextAttributes = @{
                                 NSForegroundColorAttributeName: [UIColor whiteColor]
  };
//  navBar.frame = CGRectMake(0, 0, 320, 300);
  return navBar;
}
@end
