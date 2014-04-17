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
    @"authentication_token" :   @"authenticationToken",
    @"facebook_id"          :   @"facebookId",
    @"profile_photo_url"    :   @"profilePhotoUrl",
    @"cover_photo_url"      :   @"coverPhotoUrl",
    @"level_name"           :   @"levelName",
    @"level_icon_url"       :   @"levelIconUrl",
    @"yabs"                 :   @"yabs",
  }];
  
  return mapping;
}
+ (RKMapping *)merchantStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Merchant class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
                                                @"name"                 :   @"name",
                                                @"id"                   :   @"merchantId",
                                                }];
  
  return mapping;
}
+ (RKMapping *)locationStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Location class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
                                                @"id"                   :   @"locationtId",
                                                @"latitude"             :   @"latitude",
                                                @"longitude"            :   @"longitude",
                                                }];
  
  return mapping;
}

+ (void)setUpClient {
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
  AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
  
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  
  RKResponseDescriptor *userShowDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider userStyleMapping]
                                                                                          method:RKRequestMethodGET
                                                                                     pathPattern:@"users/:id"
                                                                                         keyPath:@"user"
                                                                                     statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:userShowDescriptor];
  
  RKResponseDescriptor *userAuthenticationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider userStyleMapping]
                                                                                                    method:RKRequestMethodPOST
                                                                                               pathPattern:@"authentication"
                                                                                                   keyPath:@"user"
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:userAuthenticationDescriptor];

  RKResponseDescriptor *merchantIndexDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider merchantStyleMapping]
                                                                                                    method:RKRequestMethodGET
                                                                                               pathPattern:@"merchants"
                                                                                                   keyPath:@"merchants"
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:merchantIndexDescriptor];
  
  RKResponseDescriptor *locationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider locationStyleMapping]
                                                                                                    method:RKRequestMethodPOST
                                                                                               pathPattern:@"locations"
                                                                                                   keyPath:@"location"
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:200]];
  [objectManager addResponseDescriptor:locationDescriptor];
}

@end
