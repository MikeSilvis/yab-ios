//
//  LoginViewController.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"
#import "AppDelegate.h"
#import <RestKit/RestKit.h>

@interface LoginViewController : UIViewController <FBLoginViewDelegate>

@property (nonatomic, assign) BOOL isFirstLoginDone;

@end
