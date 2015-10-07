//
//  OrderTrackViewController.m
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/6/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "OrderTrackViewController.h"
#import "RESideMenu.h"
#import "WebHandler.h"
#import "AppDelegate.h"
#import "OrderCell.h"

@interface OrderTrackViewController ()

@property NSArray *orders;

@end

@implementation OrderTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];

    self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
    
    [[AppDelegate instance] showBusyView:@"Loading Orders"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
    
    [WebHandler getTrackOrdersWithUserId:userId withCallback:^(id object, NSError *error) {
        
        self.orders = object;
        
       dispatch_async(dispatch_get_main_queue(), ^{
           [[AppDelegate instance] hideBusyView];
           
           [orderTableView reloadData];
       });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _orders.count;
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderCell *cell = (OrderCell*)[tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict = _orders[indexPath.row];
    
    cell.lblOrderId.text = dict[@"order_id"];
    cell.lblDate.text = dict[@"date_added"];
    cell.lblStatus.text = dict[@"status"];
    
    float price = 0.0;
    
    for (NSDictionary *prodDict in dict[@"products"]) {
       price = price + [prodDict[@"price"] floatValue];
    }
    
    cell.lblTotal.text = [NSString stringWithFormat:@"GHS %.2f", price];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 107;
}

@end
