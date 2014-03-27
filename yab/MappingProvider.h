//
//  MappingProvider.h
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "User.h"
#import "Venue.h"

@interface MappingProvider : NSObject

+ (RKMapping *)userStyleMapping;
+ (RKMapping *)venueStyleMapping;
+ (void)setUpClient;

@end
