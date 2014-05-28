//
//  ViewController.m
//  MobileMapper
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mobileMakersAnnotation = [[MKPointAnnotation alloc] init];
    self.mobileMakersAnnotation.coordinate = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
    self.mobileMakersAnnotation.title = @"Mobile Makers HQ";
    [self.mapView addAnnotation:self.mobileMakersAnnotation];
    
    [self addAddress:@"Mt. Rushmore"];
    [self addAddress:@"Texas"];
    [self addAddress:@"JFK"];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.image = [UIImage imageNamed:@"mobilemakers"];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

- (void)addAddress:(NSString *)address
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = address;
            annotation.coordinate = placemark.location.coordinate;
            [self.mapView addAnnotation:annotation];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    CLLocationCoordinate2D centerCoordinate = view.annotation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(.01, .01);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    [self.mapView setRegion:region animated:YES];
}

@end
