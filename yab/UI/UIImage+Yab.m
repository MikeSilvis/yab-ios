//
//  UIImage+Yab.m
//  Yab
//
//  Created by Mike Silvis on 4/16/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "UIImage+Yab.h"
#import "AppDelegate.h"

@implementation UIImage (Yab)
+ (UIImage*) drawText:(NSString*)text inImage:(UIImage*)image atPoint:(CGPoint)point {
  
  UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
   UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [image drawInRect:CGRectMake(0,0,image.size.width, image.size.height)];
    NSDictionary *dict = @{ NSFontAttributeName:font, NSForegroundColorAttributeName: WHITECOLOR };
    CGRect rect = CGRectMake(
                              ((image.size.width - [text sizeWithAttributes:dict].width) / 2),
                              0,
                              image.size.width,
                              image.size.height
                             );
  
    [text drawInRect:CGRectIntegral(rect) withAttributes:dict];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}
+(UIImage *)profilePhotoImage:(NSURL *)url {
  UIImage *image = [UIImage imageNamed:@"blankAvatar"];
  
  return image;
}
@end
