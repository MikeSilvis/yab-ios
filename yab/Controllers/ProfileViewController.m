//
//  SecondViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "UIProgressView+Yab.h"
#import "MerchantViewController.h"
#import "ProfilePhotoView.h"
#import "LevelView.h"
#import "DefaultTable.h"

@interface ProfileViewController ()

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Me";
    [self loadStyles];
    [self loadPage];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushSegue:) name:@"selectedRow" object:nil];
}

- (User *)user {
  if (!!_user) {
    return _user;
  } else {
    return [User currentUser];
  }
}

- (void)loadStyles {
  FAKFontAwesome *cogIcon = [FAKFontAwesome cogIconWithSize:2];
  [cogIcon addAttribute:NSForegroundColorAttributeName value:WHITECOLOR];
  cogIcon.iconFontSize = 20;
  self.settingsGear.image = [cogIcon imageWithSize:CGSizeMake(30, 30)];

  // Navigation
  [self preferredStatusBarStyle];
  self.navigationController.navigationBar.barTintColor = BLACKCOLOR;
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.titleTextAttributes = @{
                                                                  NSForegroundColorAttributeName: WHITECOLOR
                                                                  };
  self.navigationController.navigationBar.tintColor = WHITECOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)loadPage {
  ProfilePhotoView *photoView = [[ProfilePhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 153)];
  photoView.profilePhotoUrl = self.user.avatarUrl;
  photoView.coverPhotoUrl   = self.user.coverPhotoUrl;
  [photoView render];
  [self.view addSubview:photoView];
  
  LevelView *levelView = [[LevelView alloc] initWithFrame:CGRectMake(0, 153, self.view.frame.size.width, 50)];
  levelView.iconUrl = self.user.level.iconUrl;
  levelView.points  = self.user.level.points;
  levelView.name    = self.user.level.name;
  [levelView render];
  [self.view addSubview:levelView];
  
  DefaultTable *defaultTable = [[DefaultTable alloc] initWithFrame:CGRectMake(0, 202, self.view.frame.size.width, 300)];
  defaultTable.objects = self.user.merchants;
  defaultTable.tableLabel = @"Recent Checkins";
  [defaultTable render];
  [self.view addSubview:defaultTable];
}

- (void)pushSegue:(NSNotification *)notification {
  self.merchantToPush = notification.object;
  [self performSegueWithIdentifier:@"merchantSegue" sender:self];
}

- (IBAction)settingsGearTouched:(id)sender {
  [self performSegueWithIdentifier:@"settingsModal" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"merchantSegue"]){
    MerchantViewController *destViewController = segue.destinationViewController;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedRow" object:nil];
    destViewController.merchant = self.merchantToPush;
  }
}
@end
