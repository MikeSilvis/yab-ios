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
  self.navigationItem.titleView = [self titleView];
  [self loadStyles];

  if ([User isLoggedIn]) {
    [self loadBars];
  }
  
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:YES];
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
- (UIView *)titleView {
  CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
  CGFloat width = 0.95 * self.view.frame.size.width;
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, navBarHeight)];
  
  UIImage *logo = [UIImage imageNamed:@"logoHeader"];
  
  UIButton *logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [logoButton setEnabled:NO];
  CGFloat logoY = floorf((navBarHeight - logo.size.height) / 2.0f) + 3;
  CGFloat centerPosition = floorf((width - logo.size.width) / 2.0f);
  
  [logoButton setFrame:CGRectMake(centerPosition, logoY, logo.size.width, logo.size.height)];
  [logoButton setImage:logo forState:UIControlStateDisabled];
  
  [containerView addSubview:logoButton];
  
  return containerView;
}
- (void)loadBars {
  [[RKObjectManager sharedManager] getObjectsAtPath:@"merchants"
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
                            
//                            [User log]
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                            message:[error localizedDescription]
//                                                                           delegate:nil
//                                                                  cancelButtonTitle:@"OK"
//                                                                  otherButtonTitles:nil];
//                            [alert show];
                          }];
}

@end
