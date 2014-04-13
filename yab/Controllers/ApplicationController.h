//
//  ApplicationController.h
//  yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define BEACON_UUID @"259B43F9-F6B7-498D-9448-BCF5EAAF1C85"
#define IDENTIFIER @"Yab.Yab"

@interface ApplicationController : UITabBarController  <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
