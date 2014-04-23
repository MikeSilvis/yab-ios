//
//  NotificationPopup.h
//  Yab
//
//  Created by Mike Silvis on 4/12/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ApplicationController.h"
#import "Checkin.h"

@interface NotificationPopupView : UIView

- (id)initWithCheckin:(Checkin *)checkin frame:(CGRect)aRect;
@property (nonatomic) Checkin* checkin;

@end
