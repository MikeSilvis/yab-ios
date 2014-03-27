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
    @"phone_number"         :   @"phoneNumber",
    @"authentication_token" :   @"authenticationToken"
  }];
  
  return mapping;
}
+ (RKMapping *)venueStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Venue class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
                                                @"name"                 :   @"name",
                                                @"id"                   :   @"venueId",
                                                }];
  
  return mapping;
}

+ (void)setUpClient {
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
//      [[[RKObjectManager sharedManager] HTTPClient] setAuthorizationHeaderWithToken:@"hello"];
  
  
  AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
  
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  
  RKResponseDescriptor *userShowDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider userStyleMapping]
                                                                                          method:RKRequestMethodGET
                                                                                     pathPattern:@"users/:id"
                                                                                         keyPath:@"users"
                                                                                     statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:userShowDescriptor];
  
  RKResponseDescriptor *userAuthenticationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider userStyleMapping]
                                                                                                    method:RKRequestMethodPOST
                                                                                               pathPattern:@"authentication"
                                                                                                   keyPath:@"user"
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:userAuthenticationDescriptor];

  RKResponseDescriptor *veneuIndexDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider venueStyleMapping]
                                                                                                    method:RKRequestMethodGET
                                                                                               pathPattern:@"venues"
                                                                                                   keyPath:@"venues"
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:veneuIndexDescriptor];
}

@end
