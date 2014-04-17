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
  [self loadMerchants];

}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:YES];
  
  if ([User isLoggedIn]) {
    [self loadMerchants];
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
- (void)loadMerchants {
  [[RKObjectManager sharedManager] getObjectsAtPath:@"merchants"
                                         parameters:@{
                                                      @"authentication_token": [[User currentUser] authenticationToken]
                                                      }
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                            NSArray *merchantList = mappingResult.array;
                            _merchants = [[NSMutableArray alloc]init];
                            for (id object in merchantList) {
                              Merchant *merchant = object;
                              [_merchants addObject:merchant.name];
                            }
                            if(self.isViewLoaded)
                              [_merchantTable reloadData];
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
  return [_merchants count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier= @"Merchant";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  if (cell == nil){
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  cell.textLabel.text = [_merchants objectAtIndex:indexPath.row];
  cell.detailTextLabel.text = @"Promoted";
  return cell;
}

@end
