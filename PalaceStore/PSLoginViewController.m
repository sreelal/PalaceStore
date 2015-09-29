//
//  PSLoginViewController.m
//  PalaceStore
//
//  Created by Sreelal H on 30/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "HelperClass.h"

@interface PSLoginViewController ()

@end

@implementation PSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)loginWithFB:(id)sender {
    
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"public_profile"]) {
        // TODO: publish content.
        [self performSegueWithIdentifier:@"loginSegue" sender:sender];
    } else {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        __weak PSLoginViewController *weakSelf = self;
        [loginManager logInWithReadPermissions:@[@"public_profile"]
                            fromViewController:self
                                       handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                           
           if (error||result.isCancelled) {
               NSLog(@"Process error or Cancelled");
               dispatch_async(dispatch_get_main_queue(), ^{

                   [HelperClass showAlertWithMessage:@"An unexpected error occured.Please try again later."];
               });
           } else {
               NSLog(@"Logged in");
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   [weakSelf performSegueWithIdentifier:@"loginSegue" sender:sender];
                   
               });
           }
       }];
    }
    
}


- (IBAction)unwindVC:(UIStoryboardSegue *)unwindSegue
{
    
}
@end
