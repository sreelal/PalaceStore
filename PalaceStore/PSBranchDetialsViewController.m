//
//  PSBranchDetialsViewController.m
//  PalaceStore
//
//  Created by Sreelal H on 17/10/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSBranchDetialsViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface PSBranchDetialsViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PSBranchDetialsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];

    [self performSelector:@selector(loadMapData) withObject:nil afterDelay:0.2];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initView {
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)loadMapData{
    
    NSString *_geolocationValue = _branchData[@"geocode"];
    if (_geolocationValue.length>0) {
        
        NSArray *latlong = [_geolocationValue componentsSeparatedByString:@","];
        if (latlong.count>1) {
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latlong[0] doubleValue], [latlong[1] doubleValue]);
            [annotation setCoordinate:coordinate];
            [annotation setTitle:_branchData[@"address"]]; //You can set the subtitle too
            [self.mapView addAnnotation:annotation];
            [self.mapView setCenterCoordinate:coordinate];
            
        }
    }
    
    //[self zoomUp];
    [self zoomToFitMapAnnotations:self.mapView];
}

- (void)zoomUp {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
}

- (void)zoomToFitMapAnnotations:(MKMapView*)mapView {
    
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MKPointAnnotation* annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

#pragma mark - Button Actions

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
