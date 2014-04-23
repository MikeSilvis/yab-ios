//
//  Level.h
//  Yab
//
//  Created by Mike Silvis on 4/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSNumber *points;
@property (nonatomic, copy) NSNumber *next;
@property (nonatomic, copy) NSNumber *earned;

@property (nonatomic, copy) NSURL *iconUrl;

- (float)nextLevelPercent;

@end
