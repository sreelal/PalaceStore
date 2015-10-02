//
//  CartTableViewController.m
//  PalaceStore
//
//  Created by Teja Swaroop on 21/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "CartTableViewController.h"
#import "MyCartCell.h"
#import "Cart.h"
#import "AppDelegate.h"
#import "DatabaseHandler.h"
#import "UIViewController+Refresh.h"

@interface CartTableViewController () {

}

@end

@implementation CartTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_isRerendering) {
        topConstraint.constant = 0;
        [self.view setNeedsUpdateConstraints];
    }
    
    [self fetchCartObjecs];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _isRerendering = YES;
}

#pragma mark - Button Actions

- (void)removeCartItemAtIndex:(NSInteger)index {
    
    Cart * cartObj = [self.cartArray objectAtIndex:index];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", cartObj.category_id, cartObj.product_id];
    
    [DatabaseHandler deleteItemsFromTable:@"Cart" withPredicate:predicate];
    
    [self fetchCartObjecs];
    
    [cartTableView reloadData];
}

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)fetchCartObjecs {
    
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Cart"];
    
    self.cartArray = [[[DatabaseManager sharedInstance]managedObjectContext] executeFetchRequest:request error:nil];
    
    [cartTableView reloadData];
    
    int totalPrice = 0;
    
    for (Cart *cart in self.cartArray) {
        totalPrice = totalPrice + ([cart.price intValue] * [cart.count intValue]);
    }
    
    total.text = [NSString stringWithFormat:@"GHS %d", totalPrice];
}

- (void)setupView {
    
    if (_isFromMenu) {
        self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
    }
    else if (_isFromMenuAndInnerView) {
        UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
        leftBarItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    else {
        UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
        leftBarItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = leftBarItem;
        
        UIBarButtonItem *rightBarItem = [[AppDelegate instance] getHomeBarButtonItemWithTarget:self andSelector:@selector(homeAction:)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cartArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * simpleTableIdentifier = @"MyCartCell";
    
    MyCartCell * cell = (MyCartCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCartCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Cart * cartObj = [self.cartArray objectAtIndex:indexPath.row];
    int price = [cartObj.price intValue] * [cartObj.count intValue];
    NSString *priceStr = [NSString stringWithFormat:@"GHS %@ x %@ = GHS %d", cartObj.price, cartObj.count, price];
    
    cell.callingController = self;
    cell.cart = cartObj;
    
    cell.itemName.text = cartObj.name;
    cell.itemCost.text = priceStr;
    [cell loadProductImage:cartObj.thumb_image_url];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
