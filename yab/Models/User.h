//
//  User.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "AppDelegate.h"
#import "Level.h"
#import "Merchant.h"
#import <FacebookSDK/FacebookSDK.h>

@interface User : NSObject

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *authenticationToken;
@property (nonatomic, copy) NSString *facebookId;

@property (nonatomic, copy) NSURL    *profilePhotoUrl;
@property (nonatomic, copy) NSURL    *coverPhotoUrl;

@property (nonatomic) Level* level;
@property (nonatomic) NSArray* merchants;

+ (id)currentUser;
+ (BOOL)isLoggedIn;
+ (BOOL)hasLoggedIn;
- (id)updateCurrentUser;
- (id)logOut;

@end
