//
//  LeftMenuViewController.m
//  Frankies
//
//  Created by Sreelal H on 13/06/15.
//  Copyright (c) 2015 Sreelal H. All rights reserved.
//

#import "RESideMenu.h"
#import "LeftMenuViewController.h"
#import "CartTableViewController.h"
#import "PSHomeViewController.h"
#import "WhishListViewController.h"
#import "ProfileViewController.h"
#import "PSCheckoutBaseViewController.h"
#import "OrderTrackViewController.h"
#import "PSAboutUsViewController.h"
#import "PSBranchesViewController.h"
#import "PSContactUsViewController.h"

@interface LeftMenuViewController ()

@property (nonatomic,retain)NSMutableArray *leftmenuItems;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([HelperClass is4thGeneration] || [HelperClass is5thGeneration]) {
        trailingPin.constant = 110;
    }
    else if ([HelperClass isIphone6]) {
        trailingPin.constant = 140;
    }
    
    [self.view setNeedsUpdateConstraints];
    
    _leftmenuItems = [[NSMutableArray alloc] initWithObjects:@"Home", @"Cart", @"WishList", @"Track Order", @"Branches", @"About Us", @"Contact Us",@"Call Us", nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
    
    if (userId)
        [loginBtn setTitle:@"Logout" forState:UIControlStateNormal];
    else
        [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
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

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Palace Stores" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark - Button Actions

- (void)changeLoginTitle {
    
    [loginBtn setTitle:@"Logout" forState:UIControlStateNormal];
}

- (IBAction)logIn_Out:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
    
    if (userId != nil) {
        [userDefaults removeObjectForKey:KEY_USER_INFO_CUSTOMER_ID];
        [userDefaults removeObjectForKey:KEY_USER_INFO_ADDRESS_ID];
        [userDefaults removeObjectForKey:KEY_USER_INFO_FIRST_NAME];
        [userDefaults removeObjectForKey:KEY_USER_INFO_LAST_NAME];
        [userDefaults removeObjectForKey:KEY_USER_INFO_TELE];
        
        [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
        
        [self showAlertWithMessage:@"Successfully logged out!"];
    }
    else {
        PSCheckoutBaseViewController *psCheckoutView = (PSCheckoutBaseViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PSCheckoutBaseViewController"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:psCheckoutView];
        psCheckoutView.leftMenuVC = self;
        psCheckoutView.isLeftMenu = YES;
        
        [self presentViewController:navVC animated:YES completion:nil];
    }
}

#pragma mark - Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_leftmenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = _leftmenuItems[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_%ld", (long)indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Home"]) {
        PSHomeViewController * homeObj = (PSHomeViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"homeNavigationVC"];
        [self.sideMenuViewController setContentViewController:homeObj];
        
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"WishList"]) {
        WhishListViewController * whishListObj = (WhishListViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"WhishListViewController"];
        whishListObj.isFromMenu = YES;
        
        UINavigationController * whishNav = [[UINavigationController alloc]initWithRootViewController:whishListObj];
        [self.sideMenuViewController setContentViewController:whishNav];
        
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Cart"]) {
        CartTableViewController * cartObj = (CartTableViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"CartTableViewController"];
        cartObj.isFromMenu = YES;
        UINavigationController * cartNav = [[UINavigationController alloc]initWithRootViewController:cartObj];
        [self.sideMenuViewController setContentViewController:cartNav];
 
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Profile"]) {
        ProfileViewController * profileView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        profileView.isFromMenu = YES;
        UINavigationController * profNav = [[UINavigationController alloc]initWithRootViewController:profileView];
        [self.sideMenuViewController setContentViewController:profNav];
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Track Order"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
        
        if (!userId) {
            [self showAlertWithMessage:@"User is not logged in!"];
        }
        else {
            OrderTrackViewController * orderView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"OrderTrackViewController"];
            UINavigationController * orderNav = [[UINavigationController alloc]initWithRootViewController:orderView];
            [self.sideMenuViewController setContentViewController:orderNav];
        }
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Branches"]) {
        PSBranchesViewController * branchesVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"BranchesVC"];
        UINavigationController * branchNav = [[UINavigationController alloc]initWithRootViewController:branchesVC];
        [self.sideMenuViewController setContentViewController:branchNav];
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Contact Us"]) {
        PSContactUsViewController * contactUsView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ContactUsVC"];
        UINavigationController * contactusNav = [[UINavigationController alloc]initWithRootViewController:contactUsView];
        [self.sideMenuViewController setContentViewController:contactusNav];
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"About Us"]) {
        PSAboutUsViewController * aboutView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AboutUsVC"];
        UINavigationController * aboutNav = [[UINavigationController alloc]initWithRootViewController:aboutView];
        [self.sideMenuViewController setContentViewController:aboutNav];
    }
    else if ([[_leftmenuItems objectAtIndexedSubscript:indexPath.row] isEqualToString:@"Call Us"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0302814370"]];

    }
    
    [self.sideMenuViewController hideMenuViewController];
}

@end
