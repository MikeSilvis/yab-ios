//
//  FirstViewController.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TownViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *merchantTable;

@property (strong, nonatomic) NSMutableArray *merchants;

@end
