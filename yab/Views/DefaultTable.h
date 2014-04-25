//
//  DefaultTable.h
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultTable : UIView  <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *defaultTable;
@property (strong, nonatomic) IBOutlet NSArray *objects;
@property (strong, nonatomic) NSString *tableLabel;

@property (strong, nonatomic) UIProgressView *progressBar;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *merchantNameLabel;
@property (strong, nonatomic) UILabel *badgeIconText;
@property float merchantPoints;

- (void)render;

@end
