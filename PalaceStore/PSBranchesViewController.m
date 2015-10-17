//
//  PSLocationViewController.m
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/17/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSBranchesViewController.h"
#import "AppDelegate.h"
#import "WebHandler.h"

@interface PSBranchesViewController ()

@end

@implementation PSBranchesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadBranches];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)loadBranches {
    
    [[AppDelegate instance] showBusyView:@"Loading..."];

    [WebHandler getBranchesWithCallback:^(id object, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (object != nil) {
                
            }
            else {
                [HelperClass showAlertWithMessage:@"Failed to get Branches!"];
            }
            
            [[AppDelegate instance] hideBusyView];
        });
    }];
}

- (void)setupView {
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
}

#pragma mark - Button Actions

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
