//
//  Reward.h
//  Yab
//
//  Created by Mike Silvis on 4/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reward : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *points;
@property (nonatomic, copy) NSURL    *avatarUrl;

@end
