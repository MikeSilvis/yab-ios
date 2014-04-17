//
//  LoadingController.m
//  Yab
//
//  Created by Mike Silvis on 4/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "LoadingController.h"

@implementation LoadingController

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:NO];
  [self findCurrentUser];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}
- (void)findCurrentUser {
  NSString *url = [NSString stringWithFormat:@"users/%@", [[User currentUser] userId]];
  
  [[RKObjectManager sharedManager] getObjectsAtPath:url
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              [[mappingResult firstObject] updateCurrentUser];
                                              [self dismissViewControllerAnimated:NO completion:nil];
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              [[User currentUser] logOut];
                                              [self dismissViewControllerAnimated:NO completion:nil];
                                            }
   ];
}

@end
