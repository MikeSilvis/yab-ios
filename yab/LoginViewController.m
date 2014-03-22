//
//  LoginViewController.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "LoginViewController.h"
#import "MappingProvider.h"

@implementation LoginViewController

- (void)viewDidLoad {
  [self addFacebookButton];
}

- (void)addFacebookButton {
  FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email"]];
  loginView.delegate = self;
  loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 400);
  [self.view addSubview:loginView];
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
  self.isFirstLoginDone = YES;
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
  
  if (self.isFirstLoginDone) {
    NSString *fbAccessToken = [FBSession activeSession].accessTokenData.accessToken;
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    id params = @{@"user": @{ @"facebook_auth_token":fbAccessToken } };
    [objectManager postObject:params path:@"authentication" parameters:params
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                        User *user = [mappingResult firstObject];
                        NSLog(@"%@", user.name);
                      }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                      }];
  }

}

@end
