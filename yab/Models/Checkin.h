//
//  Checkin.h
//  Yab
//
//  Created by Mike Silvis on 4/21/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Merchant.h"
#import "Location.h"

@interface Checkin : NSObject 

@property (nonatomic, copy) NSString *checkinId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic) int points;
@property (nonatomic) int nextLevelPoints;

@property (nonatomic) User* user;
@property (nonatomic) Merchant* merchant;
@property (nonatomic) Location* location;

- (float)nextLevelPercent;

@end
