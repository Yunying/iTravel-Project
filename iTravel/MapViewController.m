//
//  MapViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/7/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i=0; i<_locations.count; i++){
        NSDictionary* dic = (NSDictionary*)_locations[i];
        float lat = [dic[@"Latitude"] floatValue];
        float lon = [dic[@"Longitude"] floatValue];
        CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(lat,lon);
        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
        [annotation1 setTitle:[NSString stringWithFormat:@"%@ %d", @"Image", i]];
        [annotation1 setCoordinate:coord1];
        [_map addAnnotation:annotation1];
    }
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in _map.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.5, 0.5);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [_map setVisibleMapRect:zoomRect animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
