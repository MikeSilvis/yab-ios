//
//  UIImage+Yab.h
//  Yab
//
//  Created by Mike Silvis on 4/16/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface UIImage (Yab)
+(UIImage*) drawText:(NSString*)text inImage:(UIImage*)image atPoint:(CGPoint)point;
@end