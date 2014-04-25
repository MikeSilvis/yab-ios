//
//  LevelView.h
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

@property (nonatomic, copy) NSURL    *iconUrl;
@property (nonatomic, copy) NSNumber *points;
@property (nonatomic, copy) NSString *name;

- (void)render;

@end
