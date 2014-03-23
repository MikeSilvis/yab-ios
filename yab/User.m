//
//  User.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "User.h"

@implementation User

+ (id)currentUser {
  return [NSUserDefaults standardUserDefaults];
}
+ (BOOL)isLoggedIn{
  return !![User currentUser];
}
- (id)setCurrentUser {
  
  NSUserDefaults *session = [User currentUser];
  
  [session setObject:self.authenticationToken forKey:@"authenticationToken"];
  
  [session synchronize];

  return self;
}

@end
