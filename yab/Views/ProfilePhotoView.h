//
//  ProfilePhotoView.h
//  Yab
//
//  Created by Mike Silvis on 4/24/14.
//  Copyright (c) 2014 Mike Silvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Merchant.h"
#import <MapKit/MapKit.h>

@interface ProfilePhotoView : UIView <MKMapViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) NSURL    *coverPhotoUrl;
@property (nonatomic, copy) NSURL    *profilePhotoUrl;

@property (nonatomic) Merchant *merchant;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (void)render;
- (void)renderMap;
- (void)renderCoverPhoto;
- (void)openInNative;

@end
