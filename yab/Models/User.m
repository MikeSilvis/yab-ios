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
+ (void) findCurrent {
  NSString *url = [NSString stringWithFormat:@"users/%@", [[User currentUser] userId]];
  
  [[RKObjectManager sharedManager] getObjectsAtPath:url
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              [[mappingResult firstObject] updateCurrentUser];
                                            }
                                            failure:nil
   ];
}
+ (BOOL)isLoggedIn {
  return !![[User currentUser] name];
}

+ (BOOL)hasLoggedIn {
  return !![[NSUserDefaults standardUserDefaults] objectForKey:@"authenticationToken"];
}

- (id)updateCurrentUser {
  User *currentUser = [User currentUser];
  currentUser.name = self.name;
  currentUser.userId = self.userId;
  currentUser.authenticationToken = self.authenticationToken;
  currentUser.phoneNumber = self.phoneNumber;
  [currentUser syncUserDefaults];
  
  return currentUser;
}

- (void)syncUserDefaults {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject: _authenticationToken forKey:@"authenticationToken"];
  [defaults setObject: _userId forKey:@"userId"];
  [defaults synchronize];
}

- (NSString *)userId {
  if (_userId) {
    return _userId;
  } else {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
  }
}

- (NSString *)authenticationToken {
  if (_authenticationToken) {
    return _authenticationToken;
  } else {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"authenticationToken"];
  }
}

- (id)logOut {
  User *currentUser = [User currentUser];
  currentUser.authenticationToken = nil;
  [currentUser syncUserDefaults];

  return currentUser;
}

@end
