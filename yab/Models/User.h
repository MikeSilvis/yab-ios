//
//  User.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *authenticationToken;
@property (nonatomic, copy) NSString *profilePhotoUrl;
@property (nonatomic, copy) NSString *coverPhotoUrl;
@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *levelIconUrl;
@property (nonatomic, copy) NSString *yabs;

+ (id)currentUser;
+ (BOOL)isLoggedIn;
+ (BOOL)hasLoggedIn;
- (id)updateCurrentUser;
- (id)logOut;

@end
