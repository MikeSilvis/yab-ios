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

//@property (nonatomic, copy) NSString *username;
//@property (nonatomic, copy) NSString *gender;
//@property (nonatomic, copy) NSString *email;
//@property (nonatomic, copy) NSString *birthday;
//@property (nonatomic, copy) NSString *facebookId;
//@property (nonatomic, copy) NSString *city;

+ (id)currentUser;
+ (BOOL)isLoggedIn;
+ (BOOL)hasLoggedIn;
+ (void)findCurrent;
- (id)updateCurrentUser;
- (id)logOut;

@end
