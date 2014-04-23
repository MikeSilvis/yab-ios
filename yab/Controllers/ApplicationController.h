//
//  ApplicationController.h
//  yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define BEACON_UUID @"DF230DEF-F8FD-4C63-B89D-D8907EEDD6A7"
#define IDENTIFIER @"Yab.Yab"

@interface ApplicationController : UITabBarController  <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *locationsSent;

@end
