//
//  FirstViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "TownViewController.h"
#import "User.h"
#import "Merchant.h"
#import "AppDelegate.h"

@interface TownViewController ()

@end

@implementation TownViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.navigationController.topViewController.title = @"Town";
  [self loadStyles];
  [self loadBars];

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
  [[RKObjectManager sharedManager] getObjectsAtPath:@"merchants"
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                            NSArray *barlist = mappingResult.array;
                            _bars = [[NSMutableArray alloc]init];
                            for (id object in barlist) {
                              Merchant *bar = object;
                              [_bars addObject:bar.name];
                            }
                            if(self.isViewLoaded)
                              [_barTable reloadData];
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                            message:[error localizedDescription]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                          }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_bars count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier= @"Merchant";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  if (cell == nil){
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  cell.textLabel.text = [_bars objectAtIndex:indexPath.row];
  cell.detailTextLabel.text = @"Promoted";
  return cell;
}

@end
