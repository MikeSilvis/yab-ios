//
//  SecondViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "UIImage+Yab.h"
#import "UIProgressView+Yab.h"
#import "MerchantViewController.h"

@interface ProfileViewController ()

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Me";
    [self loadImages];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self loadStyles];
    [self loadLevel];
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
  
  // Achievements Bar
  self.achievementsBar.backgroundColor = BLACKCOLOR;
  self.achievementsBar.translucent = NO;
  [[UITabBar appearance] setSelectedImageTintColor:WHITECOLOR];
  [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName: WHITECOLOR,
                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:10.0f]
                                                      }
                                           forState:UIControlStateNormal];
  
  // Table View
  self.merchantTable.separatorColor = [UIColor clearColor];

  self.navigationController.navigationBar.tintColor = WHITECOLOR;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}
- (void)loadImages {
  // Profile Photo
  if (!![self.user.profilePhotoUrl host]) {
    [self.profilePhoto setImageWithURL:self.user.profilePhotoUrl];
  } else {
    [self.profilePhoto setImage:[UIImage imageNamed:@"blankAvatar"]];
  }

  self.profilePhoto.layer.borderColor = BLACKCOLOR.CGColor;
  self.profilePhoto.layer.borderWidth = 3;
  self.profilePhoto.layer.masksToBounds = YES;
  self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.height /2;
  self.profilePhoto.clipsToBounds = YES;

  // Cover Photo
  if (!![self.user.profilePhotoUrl host]) {
    [self.coverPhoto setImageWithURL:self.user.coverPhotoUrl];
  } else {
    [self.coverPhoto setImage:[UIImage imageNamed:@"coverDefault"]];
  }

  UIToolbar *blurToolbar = [[UIToolbar alloc] initWithFrame:self.coverPhoto.bounds];
  blurToolbar.barStyle = UIBarStyleBlackTranslucent;
  blurToolbar.translucent = YES;
  blurToolbar.alpha = 0.5;
  [self.coverPhoto addSubview:blurToolbar];
}
- (void)loadLevel {
  dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:self.user.level.iconUrl] scale:[[UIScreen mainScreen] scale]];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.achievementsBar.items[1] setFinishedSelectedImage:img
                                  withFinishedUnselectedImage:img
       ];
    });

  });
  

  [self.achievementsBar.items[1] setTitle:self.user.level.name];
  
  UIImage *customTextImage = [[UIImage drawText:[self.user.level.points stringValue]
                                       inImage:[UIImage imageNamed:@"yabs"]
                                       atPoint:CGPointMake(0, 0)]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

  [self.achievementsBar.items[0] setFinishedSelectedImage:customTextImage
                              withFinishedUnselectedImage:customTextImage
   ];

}

- (IBAction)settingsGearTouched:(id)sender {
  [self performSegueWithIdentifier:@"settingsModal" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.user.merchants count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *simpleTableIdentifier = @"merchantTableCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  Merchant *merchant = self.user.merchants[indexPath.row];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    // Add Progress Bar
    UIProgressView *progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(0, (cell.frame.size.height + 3), cell.frame.size.width, 2)];
    progressBar = [UIProgressView defaultStyles:progressBar];
    [progressBar setProgress:merchant.user_level.nextLevelPercent animated:NO];
    [cell.contentView addSubview:progressBar];
    
    // Logo
    int imageSize = 30;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (cell.frame.size.height - imageSize) / 2, imageSize, imageSize)];
    [imageView setImageWithURL:merchant.avatarUrl placeholderImage:[UIImage imageNamed:@"logo"]];
    [cell.contentView addSubview:imageView];
    imageView.layer.borderColor = BLACKCOLOR.CGColor;
    imageView.layer.borderWidth = 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = (imageSize / 2);
    imageView.clipsToBounds = YES;
    
    // Merchant Name
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, (cell.frame.size.height - 30) / 2, (cell.frame.size.width - 50), 30)];
    textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    textLabel.textColor = BLACKCOLOR;
    textLabel.text = merchant.name;
    textLabel.highlightedTextColor = WHITECOLOR;
    [cell.contentView addSubview:textLabel];
    
    // Highlight Color
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = BLACKCOLOR;
    cell.selectedBackgroundView = selectedView;
  }
  
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"merchantSegue" sender:self];
  [self.merchantTable deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"merchantSegue"]){
    NSIndexPath *indexPath = [self.merchantTable indexPathForSelectedRow];
    MerchantViewController *destViewController = segue.destinationViewController;
    destViewController.merchant = self.user.merchants[indexPath.row];
  }
}
@end
