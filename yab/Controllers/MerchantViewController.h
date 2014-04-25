//
//  MerchantViewController.h
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Merchant.h"
#import "AppDelegate.h"

@interface MerchantViewController : UIViewController

@property (nonatomic) Merchant* merchant;
@property (weak, nonatomic) IBOutlet UITableView *userTable;
@property (weak, nonatomic) IBOutlet UITabBar *achievementsBar;

@end
