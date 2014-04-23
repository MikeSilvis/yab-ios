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
#import "Level.h"

@interface Checkin : NSObject 

@property (nonatomic, copy) NSNumber *checkinId;
@property (nonatomic, copy) NSString *message;

@property (nonatomic) User* user;
@property (nonatomic) Merchant* merchant;
@property (nonatomic) Location* location;
@property (nonatomic) Level* level;

@end
