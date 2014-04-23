//
//  Checkin.m
//  Yab
//
//  Created by Mike Silvis on 4/21/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "Checkin.h"

@implementation Checkin

- (float)nextLevelPercent {
  if (self.nextLevelPoints == 0) {
    return 1;
  } else {
   return (int) self.points / (float) self.nextLevelPoints;
  }
}

@end