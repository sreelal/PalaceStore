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

@interface LeftMenuViewController ()

@property (nonatomic,retain)NSMutableArray *leftmenuItems;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftmenuItems = [[NSMutableArray alloc] initWithObjects:@"Home",@"Cart", @"WishList", @"Log Out", nil];
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

#pragma mark - Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_leftmenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = _leftmenuItems[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    [self.sideMenuViewController hideMenuViewController];
}

@end
