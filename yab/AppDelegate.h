//
//  AppDelegate.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <FacebookSDK/FacebookSDK.h>

#define SERVER_URL @"http://localhost:3000/api/v1"
//#define SERVER_URL @"http://staging.getyab.com/api/v1/"

// Colors
#define GREENCOLOR [UIColor colorWithRed:0.0 green:200.0/255.0f blue:170.0/255.0f alpha:1.0]
#define BLACKCOLOR [UIColor colorWithRed:38.0/255.0f green:38.0/255.0f blue:38.0/255.0f alpha:1.0]
#define WHITECOLOR [UIColor whiteColor]
#define BLUECOLOR [UIColor colorWithRed:54.0/255.0f green:57.0/255.0f blue:72.0/255.0f alpha:1.0]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSUUID *myUUID;

@end
