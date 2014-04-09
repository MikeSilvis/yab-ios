//
//  User.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)currentUser {
  static User *currentUser = nil;
  @synchronized(self) {
    if (currentUser == nil)
      currentUser = [[self alloc] init];
  }
  return currentUser;
}
+ (BOOL)isLoggedIn {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults objectForKey:@"authToken"];
}

- (id)updateCurrentUser {
  User *currentUser = [User currentUser];
  currentUser.name = self.name;
  currentUser.authenticationToken = self.authenticationToken;
  currentUser.phoneNumber = self.phoneNumber;
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:currentUser.authenticationToken forKey:@"authToken"];
  [defaults synchronize];
  
  return currentUser;
}
- (id)logOut {
  User *currentUser = [User currentUser];
  currentUser.authenticationToken = nil;

  return currentUser;
}

@end
