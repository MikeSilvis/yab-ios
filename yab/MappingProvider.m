//
//  MappingProvider.m
//  yab
//
//  Created by Mike Silvis on 3/8/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "MappingProvider.h"

@implementation MappingProvider

+ (RKMapping *)userStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];

  [mapping addAttributeMappingsFromDictionary:@{
    @"name"                 :   @"name",
    @"id"                   :   @"userId",
    @"authentication_token" : @"authenticationToken"
  }];
  
  return mapping;
}
@end
