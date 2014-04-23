//
//  Venue.h
//  Yab
//
//  Created by Mike Silvis on 3/25/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface Merchant : NSObject

@property (nonatomic, copy) NSNumber *merchantId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *avatarUrl;

@property (nonatomic, copy) NSArray *rewards;
@property (nonatomic, copy) NSArray *locations;

@property (nonatomic) Level *level;

@end
