//
//  ProfilePhotoView.m
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import "ProfilePhotoView.h"
#import "Location.h"
#import "WildcardGestureRecognizer.h"

@implementation ProfilePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)render {

  if (self.merchant) {
    [self renderMap];
  } else {
    [self renderCoverPhoto];
  }
  
  // Profile Photo
  int imageSize = 100;
  UIImageView *profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - imageSize) / 2, (self.frame.size.height - imageSize) / 2, imageSize, imageSize)];
  if (!![self.profilePhotoUrl host]) {
    [profilePhoto setImageWithURL:self.profilePhotoUrl];
  } else {
    [profilePhoto setImage:[UIImage imageNamed:@"blankAvatar"]];
  }
  profilePhoto.layer.borderColor = BLACKCOLOR.CGColor;
  profilePhoto.layer.borderWidth = 3;
  profilePhoto.layer.masksToBounds = YES;
  profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height /2;
  profilePhoto.clipsToBounds = YES;
  [self addSubview:profilePhoto];
}

- (void)renderMap {
  self.mapView = [[MKMapView alloc] initWithFrame:self.frame];
  self.mapView.delegate = self;
  [self addSubview:self.mapView];
  
  Location *location = self.merchant.locations[0];
  
  CLLocationCoordinate2D annotationCoord = CLLocationCoordinate2DMake([location.latitude floatValue], [location.longitude floatValue]);
  
  MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
  annotationPoint.coordinate = annotationCoord;
  annotationPoint.title = self.merchant.name;
  annotationPoint.subtitle = location.message;
  [self.mapView addAnnotation:annotationPoint];
  
  CLLocationCoordinate2D offsetCord = CLLocationCoordinate2DMake([location.latitude floatValue], [location.longitude floatValue] + .0029f);
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(offsetCord, 400, 400);
  [self.mapView setRegion:region animated:YES];
  
  WildcardGestureRecognizer * tapInterceptor = [[WildcardGestureRecognizer alloc] init];
  tapInterceptor.touchesBeganCallback = ^(NSSet * touches, UIEvent * event) {
    [self openInNative];
  };
  [self.mapView addGestureRecognizer:tapInterceptor];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
  // If it's the user location, just return nil.
  if ([annotation isKindOfClass:[MKUserLocation class]])
    return nil;
  
  // Handle any custom annotations.
  if ([annotation isKindOfClass:[MKPointAnnotation class]])
  {
    // Try to dequeue an existing pin view first.
    MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    if (!pinView)
    {
      // If an existing pin view was not available, create one.
      pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
//      pinView.animatesDrop = YES;
      pinView.canShowCallout = YES;
      pinView.image = [UIImage imageNamed:@"pin"];
      pinView.calloutOffset = CGPointMake(0, 32);
    } else {
      pinView.annotation = annotation;
    }
    return pinView;
  }
  return nil;
}
- (void)renderCoverPhoto {
  UIImageView *coverPhoto = [[UIImageView alloc] initWithFrame:self.frame];
  if (!![self.coverPhotoUrl host]) {
    [coverPhoto setImageWithURL:self.coverPhotoUrl];
  } else {
    [coverPhoto setImage:[UIImage imageNamed:@"coverDefault"]];
  }
  coverPhoto.contentMode = UIViewContentModeScaleAspectFill;
  coverPhoto.clipsToBounds = YES;
  [self addSubview:coverPhoto];
  
  UIToolbar *blurToolbar = [[UIToolbar alloc] initWithFrame:coverPhoto.bounds];
  blurToolbar.barStyle = UIBarStyleBlackTranslucent;
  blurToolbar.translucent = YES;
  blurToolbar.alpha = 0.5;
  [coverPhoto addSubview:blurToolbar];
}
- (void)openInNative {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open in"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];

  [actionSheet addButtonWithTitle:@"Apple Maps"];
  
  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
    [actionSheet addButtonWithTitle:@"Google Maps"];
    actionSheet.cancelButtonIndex = 2;
  } else {
    actionSheet.cancelButtonIndex = 1;
  }
  
  [actionSheet addButtonWithTitle:@"Cancel"];

  [actionSheet showInView:self];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if ([actionSheet.title isEqual:@"Open in"]) {
    switch (buttonIndex) {
      case 0:
        [self openAppleMaps];
        break;
      case 1:
        [self openGoogleMaps];
        break;
    }
  }
}
- (void)openGoogleMaps {
  Location *location = self.merchant.locations[0];
  NSString *street = [location.street stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSString *url = [NSString stringWithFormat:@"comgooglemaps://?q=%@&center=%@,%@", street, location.latitude, location.longitude];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
- (void)openAppleMaps {
  Location *location = self.merchant.locations[0];
  NSString *url = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@,%@", location.latitude, location.longitude];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
