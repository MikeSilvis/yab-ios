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
#import "NotificationPopupView.h"
#import "Checkin.h"

@implementation ApplicationController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  [self testNotification];
  
  if ([User hasLoggedIn]) {
    if (![User isLoggedIn]) {
      [self loginUser];
    }
  } else {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  }
}
- (void)loginUser {
  NSString *url = [NSString stringWithFormat:@"users/%@", [[User currentUser] userId]];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginFailed:) name:@"LoginFailed" object:nil];
  
   __block id weakSelf = self;
  [[RKObjectManager sharedManager] getObjectsAtPath:url
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              [[mappingResult firstObject] updateCurrentUser];
                                              [self setupBeaon];
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              [[User currentUser] logOut];
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFailed" object:weakSelf];
                                            }
   ];
}

- (void)LoginFailed:(NSNotification *) notification {
  if ([FBSession activeSession]) {
    id params = @{@"user": @{ @"facebook_auth_token":[FBSession activeSession].accessTokenData.accessToken } };
    [[RKObjectManager sharedManager] postObject:params path:@"authentication" parameters:params
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                          [[mappingResult firstObject] updateCurrentUser];
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                          [self performSegueWithIdentifier:@"loginSegue" sender:self];
                                        }
     ];
  } else {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
  }
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.locationsSent = [[NSMutableDictionary alloc] init];
  [self loadStyles];
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

- (void)setupBeaon {
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  
  NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:BEACON_UUID];
  CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                              identifier:IDENTIFIER];
  region.notifyOnEntry = YES;
  region.notifyOnExit = YES;
  region.notifyEntryStateOnDisplay = YES;
  
  [self.locationManager startMonitoringForRegion:region];
  
  [self.locationManager requestStateForRegion:region];
}
- (void)addNotification:(Checkin *)checkin {
  NotificationPopupView *notificationPopup = [[NotificationPopupView alloc] initWithCheckin:checkin frame:[[UIScreen mainScreen] bounds]];
  [self.view addSubview:notificationPopup];
  
  UILocalNotification *notification = [[UILocalNotification alloc] init];
//  notification.alertAction = [NSString stringWithFormat:@"Checkin at: %@", checkin.merchant.name];
  notification.alertBody = [NSString stringWithFormat:@"Checked in at: %@ - %@", checkin.merchant.name, checkin.message];
  notification.soundName = UILocalNotificationDefaultSoundName;
  notification.applicationIconBadgeNumber = 1;
  notification.fireDate = [NSDate date];
  [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
  if (state == CLRegionStateInside) {
    CLBeaconRegion *beaconRegion = (CLBeaconRegion *)region;
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
  }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  if ([region isKindOfClass:[CLBeaconRegion class]]) {
    CLBeaconRegion *beaconRegion = (CLBeaconRegion *)region;
    if ([beaconRegion.identifier isEqualToString:IDENTIFIER]) {
      
      [self.locationManager startRangingBeaconsInRegion:beaconRegion];
      
    }
  }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  if ([region isKindOfClass:[CLBeaconRegion class]]) {
    CLBeaconRegion *beaconRegion = (CLBeaconRegion *)region;
    if ([beaconRegion.identifier isEqualToString:IDENTIFIER]) {
      
      [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
      
    }
  }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  for (CLBeacon *beacon in beacons) {
    NSString *majorMinor = [NSString stringWithFormat:@"major:%@minor:%@", beacon.major, beacon.minor];
    
    if (!self.locationsSent[majorMinor]) {
      id params = @{ @"checkin":
                       @{ @"major":beacon.major, @"minor": beacon.minor },
                     @"authentication_token": [[User currentUser] authenticationToken]
                  };
      [[RKObjectManager sharedManager] postObject:params path:@"checkins" parameters:params
                                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            [self addNotification:[mappingResult firstObject]];
                                          }
                                          failure:nil
       ];
       [self.locationsSent setObject:@"true" forKey:majorMinor];
    }
    
  }
}
- (void)testNotification {
  id params = @{ @"checkin":
                   @{ @"major": @"1", @"minor": @"1" },
                 @"authentication_token": [[User currentUser] authenticationToken]
                 };
  [[RKObjectManager sharedManager] postObject:params path:@"checkins" parameters:params
                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        [self addNotification:[mappingResult firstObject]];
                                      }
                                      failure:nil
   ];
}
- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
