//
//  SettingsController.h
//  Yab
//
//  Created by Mike Silvis on 3/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SettingsController : UIViewController <FBLoginViewDelegate>

@property (nonatomic, assign) BOOL isFirstLoginDone;

@end
