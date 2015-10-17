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
    // Do any additional setup after loading the view.
    [self performSelector:@selector(loadMapData) withObject:nil afterDelay:0.2];
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];

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
