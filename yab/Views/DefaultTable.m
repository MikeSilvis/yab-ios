//
//  DefaultTable.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "DefaultTable.h"
#import "Merchant.h" 
#import "User.h"
#import "Reward.h"
#import "UIProgressView+Yab.h"

@implementation DefaultTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
- (void)render {
  self.defaultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];

  self.defaultTable.delegate = self;
  self.defaultTable.dataSource = self;
  
  self.defaultTable.separatorColor = [UIColor clearColor];
  
//  self.defaultTable.allowsSelection = NO;

  [self addSubview:self.defaultTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.objects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *simpleTableIdentifier = @"merchantTableCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    // Logo
    int imageSize = 30;
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (cell.frame.size.height - imageSize) / 2, imageSize, imageSize)];
    [self.logoImageView setImage: [UIImage imageNamed:@"logo"]];
    [cell.contentView addSubview:self.logoImageView];
    self.logoImageView.layer.borderColor = BLACKCOLOR.CGColor;
    self.logoImageView.layer.borderWidth = 2;
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.layer.cornerRadius = (imageSize / 2);
    self.logoImageView.clipsToBounds = YES;
  
    // Merchant Name
    self.merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, (cell.frame.size.height - 30) / 2, (cell.frame.size.width - 50), 30)];
    self.merchantNameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    self.merchantNameLabel.textColor = BLACKCOLOR;
    self.merchantNameLabel.highlightedTextColor = WHITECOLOR;
    [cell.contentView addSubview:self.merchantNameLabel];
  
    // Highlight Color
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = BLACKCOLOR;
    cell.selectedBackgroundView = selectedView;

    // If Reward
    if ([self.objects[indexPath.row] isKindOfClass:[Reward class]]) {
      int iconSize = (cell.frame.size.height / 2);
      UIView *badgeIcon = [[UIView alloc] initWithFrame:CGRectMake(0, (cell.frame.size.height - iconSize) / 2, iconSize, iconSize)];
      badgeIcon.backgroundColor = BLACKCOLOR;
      badgeIcon.layer.cornerRadius = iconSize / 2;
      self.badgeIconText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
      self.badgeIconText.textColor = WHITECOLOR;
      self.badgeIconText.font = [UIFont fontWithName:@"Helvetica" size:10];
      self.badgeIconText.textAlignment = NSTextAlignmentCenter;
    
      [badgeIcon addSubview:self.badgeIconText];
      cell.accessoryView = badgeIcon;
    } else { // Else Merchant
      self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(0, (cell.frame.size.height + 4), cell.frame.size.width, 2)];
      self.progressBar = [UIProgressView defaultStyles:self.progressBar];
      [cell.contentView addSubview:self.progressBar];
    }
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(0, (cell.frame.size.height + 4), cell.frame.size.width, 2)];
    self.progressBar = [UIProgressView defaultStyles:self.progressBar];
    [cell.contentView addSubview:self.progressBar];
    
    // All the setters
    // If Merchant
    if ([self.objects[indexPath.row] isKindOfClass:[Merchant class]]) {
      Merchant *object = self.objects[indexPath.row];
      [self.progressBar setProgress:object.user_level.nextLevelPercent animated:NO];
      
      if (!![object.avatarUrl host]) {
        [self.logoImageView setImageWithURL:object.avatarUrl
                           placeholderImage: [UIImage imageNamed:@"logo"]];
      }
      
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      self.merchantNameLabel.text = object.name;
    } else {
      Reward *object = self.objects[indexPath.row];
      [self.progressBar setProgress:(self.merchantPoints / [object.points floatValue]) animated:NO];
      if (!![object.avatarUrl host]) {
        [self.logoImageView setImageWithURL:object.avatarUrl
                           placeholderImage: [UIImage imageNamed:@"logo"]];
      }
      self.merchantNameLabel.text = object.name;
      self.badgeIconText.text = [object.points stringValue];
    }
  }
  
  return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
  [headerView setBackgroundColor:GREENCOLOR];
  
  UILabel *titleForLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.bounds.size.width, 20)];
  titleForLabel.text = self.tableLabel;
  titleForLabel.textColor = WHITECOLOR;
  titleForLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
  [headerView addSubview:titleForLabel];

  return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedRow" object:self.objects[indexPath.row]];
  [self.defaultTable deselectRowAtIndexPath:indexPath animated:YES];
}

@end
