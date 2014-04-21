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

@implementation ApplicationController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  
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
//  [self addNotification];
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
- (void)addNotification {
  NotificationPopupView *notificationPopup = [[NotificationPopupView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.view addSubview:notificationPopup];
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

- (NSString *)stringForProximity:(CLProximity)proximity {
  switch (proximity) {
    case CLProximityUnknown:    return @"Unknown";
    case CLProximityFar:        return @"Far";
    case CLProximityNear:       return @"Near";
    case CLProximityImmediate:  return @"Immediate";
    default:
      return nil;
  }
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  for (CLBeacon *beacon in beacons) {
    NSLog(@"Ranging beacon: %@", beacon.proximityUUID);
    NSLog(@"%@ - %@", beacon.major, beacon.minor);
    NSLog(@"Range: %@", [self stringForProximity:beacon.proximity]);
    
    [self setColorForProximity:beacon.proximity];
  }
}

- (void)setColorForProximity:(CLProximity)proximity {
  switch (proximity) {
    case CLProximityUnknown:
      self.view.backgroundColor = [UIColor whiteColor];
      break;
    case CLProximityFar:
      self.view.backgroundColor = [UIColor yellowColor];
      break;
    case CLProximityNear:
      self.view.backgroundColor = [UIColor orangeColor];
      break;
    case CLProximityImmediate:
      self.view.backgroundColor = [UIColor redColor];
      break;
    default:
      break;
  }
}
- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
