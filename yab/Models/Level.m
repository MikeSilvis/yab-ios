//
//  Level.m
//  Yab
//
//  Created by Mike Silvis on 4/23/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "Level.h"

@implementation Level

- (float)nextLevelPercent {
  return [self.points floatValue] / [self.next floatValue];
}

@end
