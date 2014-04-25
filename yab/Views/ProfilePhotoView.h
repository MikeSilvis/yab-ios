//
//  ProfilePhotoView.h
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProfilePhotoView : UIView

@property (nonatomic, copy) NSURL    *coverPhotoUrl;
@property (nonatomic, copy) NSURL    *profilePhotoUrl;

- (void)render;

@end
