//
//  Venue.h
//  Yab
//
//  Created by Mike Silvis on 3/25/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Merchant : NSObject

@property (nonatomic, copy) NSString *merchantId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *avatarUrl;

@end
