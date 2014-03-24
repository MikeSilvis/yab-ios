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
  return !![[User currentUser] authenticationToken];
}

- (id)updateCurrentUser {
  User *currentUser = [User currentUser];
  currentUser.name = self.name;
  currentUser.authenticationToken = self.authenticationToken;
  currentUser.phoneNumber = self.phoneNumber;
  
  return currentUser;
}

@end
