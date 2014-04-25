//
//  Location.h
//  Yab
//
//  Created by Mike Silvis on 3/27/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, copy) NSNumber *locationtId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *street;

@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *latitude;

@end
