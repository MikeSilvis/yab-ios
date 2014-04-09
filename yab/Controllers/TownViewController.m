//
//  FirstViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "TownViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface TownViewController ()

@end

@implementation TownViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.navigationController.topViewController.title = @"Town";
  [self loadStyles];

}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:YES];
  
  if ([User isLoggedIn]) {
    [self loadBars];
  }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)loadStyles {
  self.navigationController.navigationBar.barTintColor = BLACKCOLOR;
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.titleTextAttributes = @{
                                                                  NSForegroundColorAttributeName: WHITECOLOR
                                                                  };
}
- (void)loadBars {
  [[RKObjectManager sharedManager] getObjectsAtPath:@"merchant"
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                            NSArray* bars = [mappingResult array];
//                            NSLog(@"%@", bars);
//                            _statuses = statuses;
//                            if(self.isViewLoaded)
//                              [_tableView reloadData];
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                            message:[error localizedDescription]
//                                                                           delegate:nil
//                                                                  cancelButtonTitle:@"OK"
//                                                                  otherButtonTitles:nil];
//                            [alert show];
                          }];
}

@end
