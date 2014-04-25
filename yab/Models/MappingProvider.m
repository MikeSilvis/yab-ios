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
    @"avatar_url"           :   @"avatarUrl",
    @"cover_photo_url"      :   @"coverPhotoUrl"
  }];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"level"
                                                                          toKeyPath:@"level"
                                                                        withMapping:[MappingProvider levelStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"merchants"
                                                                          toKeyPath:@"merchants"
                                                                        withMapping:[MappingProvider merchantStyleMapping]]];
  
  return mapping;
}
+ (RKMapping *)levelStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Level class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
    @"name"                 :   @"name",
    @"points"               :   @"points",
    @"next"                 :   @"next",
    @"earned"               :   @"earned",
    @"icon_url"             :   @"iconUrl"
  }];
  
  return mapping;
}

+ (RKMapping *)merchantStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Merchant class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
    @"id"                   :   @"merchantId",
    @"name"                 :   @"name",
    @"avatar_url"           :   @"avatarUrl",
    @"cover_photo_url"      :   @"coverPhotoUrl"
  }];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user_level"
                                                                          toKeyPath:@"user_level"
                                                                        withMapping:[MappingProvider levelStyleMapping]]];

  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"overall_level"
                                                                          toKeyPath:@"overall_level"
                                                                        withMapping:[MappingProvider levelStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rewards"
                                                                          toKeyPath:@"rewards"
                                                                        withMapping:[MappingProvider rewardStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"locations"
                                                                          toKeyPath:@"locations"
                                                                        withMapping:[MappingProvider locationStyleMapping]]];
  
  return mapping;
}
+ (RKMapping *)locationStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Location class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
    @"id"                   :   @"locationtId",
  }];
  
  return mapping;
}
+ (RKMapping *)rewardStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Reward class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
    @"name"                 :   @"name",
    @"points"               :   @"points",
  }];
  
  return mapping;
}
+ (RKMapping *)checkinStyleMapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Checkin class]];
  
  [mapping addAttributeMappingsFromDictionary:@{
    @"id"                   :   @"checkinId",
    @"message"              :   @"message",
    @"points"               :   @"points",
    @"next_level_points"    :   @"nextLevelPoints",
  }];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
                                                                          toKeyPath:@"user"
                                                                        withMapping:[MappingProvider userStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"merchant"
                                                                          toKeyPath:@"merchant"
                                                                        withMapping:[MappingProvider merchantStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location"
                                                                          toKeyPath:@"location"
                                                                        withMapping:[MappingProvider locationStyleMapping]]];
  
  [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"level"
                                                                          toKeyPath:@"level"
                                                                        withMapping:[MappingProvider levelStyleMapping]]];
  
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
                                                                                               statusCodes:[NSIndexSet indexSetWithIndex:201]];
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
  
  RKResponseDescriptor *checkinDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider checkinStyleMapping]
                                                                                          method:RKRequestMethodPOST
                                                                                     pathPattern:@"checkins"
                                                                                         keyPath:@"checkin"
                                                                                     statusCodes:[NSIndexSet indexSetWithIndex:201]];

  [objectManager addResponseDescriptor:checkinDescriptor];
}

@end
