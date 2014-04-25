//
//  SecondViewController.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Merchant.h"
#import <FontAwesomeKit/FAKFontAwesome.h>

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet User *user;
@property (strong, nonatomic) IBOutlet Merchant *merchantToPush;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsGear;

- (IBAction)settingsGearTouched:(id)sender;

@end