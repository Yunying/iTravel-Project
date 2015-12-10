//
//  MapViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/7/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property(strong, nonatomic) NSArray* locations;

@property(strong, nonatomic) PFObject* tripObj;

@end
