//
//  WhishListViewController.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "WhishListViewController.h"
#import "MyCartCell.h"
#import "WishList.h"
#import "Products.h"
#import "DatabaseHandler.h"
#import "PSProductDetailsViewController.h"

@interface WhishListViewController ()

@end

@implementation WhishListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self fetchWhishListObjectsFromDatabase];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Actions

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (void)fetchWhishListObjectsFromDatabase {
    
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"WishList"];
    
    self.whishListArray = [[[DatabaseManager sharedInstance]managedObjectContext] executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (void)setupView {
    
    if (_isFromMenu) {
        self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
    }
    else {
        UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
        leftBarItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.whishListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * simpleTableIdentifier = @"MyCartCell";
    
    MyCartCell * cell = (MyCartCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCartCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WishList * wishObj = [self.whishListArray objectAtIndex:indexPath.row];
    NSString *priceStr = [NSString stringWithFormat:@"GHS %d", [wishObj.price intValue]];
    
    cell.itemName.text = wishObj.name;
    cell.itemCost.text = priceStr;
    [cell loadProductImage:wishObj.thumb_image_url];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WishList * wishObj = [self.whishListArray objectAtIndex:indexPath.row];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", wishObj.category_id, wishObj.product_id];
    NSArray *selProducts = [DatabaseHandler fetchItemsFromTable:@"Products" withPredicate:predicate];
    
    Products *selProduct = [selProducts firstObject];
    
    PSProductDetailsViewController *_productDetailsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PSProductDetailsViewController"];
    _productDetailsVC.selectedProduct = selProduct;
    _productDetailsVC.isFromMenu = YES;
    [self.navigationController pushViewController:_productDetailsVC animated:YES];
}

@end
