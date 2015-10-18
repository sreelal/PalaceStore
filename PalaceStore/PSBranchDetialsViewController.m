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
}

#pragma mark - Button Actions

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
