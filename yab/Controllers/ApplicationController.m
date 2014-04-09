//
//  ApplicationController.m
//  yab
//
//  Created by Mike Silvis on 3/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ApplicationController.h"
#import "AppDelegate.h"
#import "User.h"
#import "UINavigationBar+Yab.h"

@implementation ApplicationController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  [[[RKObjectManager sharedManager] HTTPClient] setAuthorizationHeaderWithToken:@"hello"];

  if (![User isLoggedIn]) {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  } else {
    [self monitorGps];
  }
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadStyles];
}

- (void)monitorGps {
  self.locationManager = [[CLLocationManager alloc] init];
  [self.locationManager setDelegate:self];
  [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

  if ([CLLocationManager locationServicesEnabled]) {
    [self.locationManager startMonitoringSignificantLocationChanges];
  }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  NSLog(@"latitude: %f longitude: %f", manager.location.coordinate.latitude, manager.location.coordinate.longitude);
  
  id params = @{
                @"authentication_token" : [[User currentUser] authenticationToken],
                @"location"             : @{
                      @"latitude"    : [NSNumber numberWithDouble:manager.location.coordinate.latitude],
                      @"longitude"   : [NSNumber numberWithDouble:manager.location.coordinate.longitude]
                    }
                };
  
  [[RKObjectManager sharedManager] postObject:params path:@"locations" parameters:params success:nil failure:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  if ([error.domain isEqualToString:kCLErrorDomain] && error.code == kCLErrorDenied) {
  }
}

- (void)loadStyles {
  [[UIBarButtonItem appearance] setTintColor:WHITECOLOR];
  [[UITabBar appearance] setTintColor:GREENCOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:10.0f]
                                                      }
                                           forState:UIControlStateNormal];
}

@end
