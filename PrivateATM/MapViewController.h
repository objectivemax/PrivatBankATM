//
//  MapViewController.h
//  PrivateATM
//
//  Created by Maxim Ohrimenko on 10/13/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

@interface MapViewController : UIViewController <GMSMapViewDelegate, UIAlertViewDelegate>


@property (nonatomic, weak) NSString *nameCity;
@property (weak, nonatomic) NSString *pathAvaForChat;

@property (weak, nonatomic) IBOutlet GMSMapView *GoogleMapView;
@property (nonatomic, strong) NSMutableArray *jsonCity;

- (void) getMap;

@end
