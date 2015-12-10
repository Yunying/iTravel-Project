//
//  MapViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/7/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "MapViewController.h"
#import "Constants.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;
@property bool updated;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _updated = false;

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
    [_locationManager requestWhenInUseAuthorization]; // Add This Line
    
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    //[self.map setCenterCoordinate:_map.userLocation.location.coordinate animated:YES];
    
    UIBarButtonItem * dropButton = [[UIBarButtonItem alloc] initWithTitle:@"Drop a pin" style:UIBarButtonItemStyleBordered target:self action:@selector(dropButtonTapped:)];
    self.navigationItem.title = @"My Footprints";
    self.navigationItem.rightBarButtonItem = dropButton;
    
    /*for (int i=0; i<_locations.count; i++){
        NSDictionary* dic = (NSDictionary*)_locations[i];
        float lat = [dic[@"Latitude"] floatValue];
        float lon = [dic[@"Longitude"] floatValue];
        CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(lat,lon);
        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
        [annotation1 setTitle:[NSString stringWithFormat:@"%@ %d", @"Image", i]];
        [annotation1 setCoordinate:coord1];
        [_map addAnnotation:annotation1];
    }*/
    
    
    
}

- (void) viewDidAppear:(BOOL)animated {


    for (int i=0; i<_locations.count; i++){
        NSDictionary* dic = (NSDictionary*)_locations[i];
        float lat = [dic[@"Latitude"] floatValue];
        float lon = [dic[@"Longitude"] floatValue];
        CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(lat,lon);
        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
        [annotation1 setTitle:dic[@"PinDate"]];
        [annotation1 setCoordinate:coord1];
        [_map addAnnotation:annotation1];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (!_updated){
        _updated = true;
        CLLocationCoordinate2D location = newLocation.coordinate;
        NSLog(@"Location: %f %f", location.latitude, location.longitude);
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=0.18;
        span.longitudeDelta=0.18;
        region.span=span;
        region.center=location;
        [self.map setRegion:region animated:TRUE];
        [self.map regionThatFits:region];
    }
    _location = newLocation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dropButtonTapped: (UIBarButtonItem*) button {
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    [pin setCoordinate:_location.coordinate];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd/MM/YYYY"];
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    [pin setTitle:date_String];
    [self.map addAnnotation:pin];
    
    [self saveToImageLocations];
}

- (void) saveToImageLocations {
    NSString* lat = [NSString stringWithFormat:@"%lf", _location.coordinate.latitude];
    NSString* lon = [NSString stringWithFormat:@"%lf", _location.coordinate.longitude];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd/MM/YYYY"];
    NSString *dateStr=[dateformate stringFromDate:[NSDate date]];
    
    NSMutableDictionary* locationDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [locationDic setObject:lat forKey:@"Latitude"];
    [locationDic setObject:lon forKey:@"Longitude"];
    [locationDic setObject:dateStr forKey:@"PinDate"];
    
    NSMutableArray* loc;
    if (_locations != nil){
        loc = [[NSMutableArray alloc] initWithArray:_locations];
    } else {
        loc = [[NSMutableArray alloc]init];
    }
    
    [loc addObject:locationDic];
    
    _tripObj[kImageLocations] = loc;
    [_tripObj save];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    if(annotation!= _map.userLocation)
    {
        static NSString *defaultPin = @"pinIdentifier";
        pinView = (MKPinAnnotationView*)[_map dequeueReusableAnnotationViewWithIdentifier:defaultPin];
        if(pinView == nil)
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPin];
        pinView.pinColor = MKPinAnnotationColorPurple; //Optional
        pinView.canShowCallout = YES; // Optional
        pinView.animatesDrop = YES;
    }
    return pinView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
