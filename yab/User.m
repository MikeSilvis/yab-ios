//
//  User.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "User.h"
#import "SSKeychain.h"

//#define SERVICE_NAME @"Yab-Facebook"
//#define AUTH_TOKEN_KEY @"token"

@implementation User

//- (id)initWithFacebook:(FBGraphUser *)user {

//}
//- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
//  NSLog(@"%@", user);
  //  self.profilePictureView.profileID = user.id;
  //  self.nameLabel.text = user.name;
//}
//- (BOOL)isLoggedIn {
//  return [self authToken] != nil;
//}
//
//- (void)clearSavedCredentials {
//  [self setAuthToken:nil];
//}
//
//- (NSString *)authToken {
//  return [self secureValueForKey:AUTH_TOKEN_KEY];
//}
//
//- (void)setAuthToken:(NSString *)authToken {
//  [self setSecureValue:authToken forKey:AUTH_TOKEN_KEY];
//  [[NSNotificationCenter defaultCenter] postNotificationName:@"token-changed" object:self];
//}
//
//- (void)setSecureValue:(NSString *)value forKey:(NSString *)key {
//  if (value) {
//    [SSKeychain setPassword:value
//                 forService:SERVICE_NAME
//                    account:key];
//  } else {
//    [SSKeychain deletePasswordForService:SERVICE_NAME account:key];
//  }
//}
//
//- (NSString *)secureValueForKey:(NSString *)key {
//  return [SSKeychain passwordForService:SERVICE_NAME account:key];
//}
@end
