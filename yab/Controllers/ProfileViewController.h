//
//  SecondViewController.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <FontAwesomeKit/FAKFontAwesome.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet User *user;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsGear;

- (IBAction)settingsGearTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *coverPhoto;
@property (weak, nonatomic) IBOutlet UITabBar *achievementsBar;
@property (weak, nonatomic) IBOutlet UITableView *merchantTable;

@end