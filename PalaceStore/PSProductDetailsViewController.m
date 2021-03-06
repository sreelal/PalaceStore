//
//  PSProductDetailsViewController.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSProductDetailsViewController.h"
#import "WebHandler.h"
#import "DatabaseHandler.h"
#import "Products.h"
#import "Constants.h"
#import "Product_Details.h"
#import "Product_Attributes.h"
#import "ProductImageCell.h"
#import "PriceInfoCell.h"
#import "Cart.h"
#import "ProductDescriptionCell.h"
#import "ProductSpecificationCell.h"
#import "PSProductSpecificationsViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "CartTableViewController.h"
#import "WishList.h"

@interface PSProductDetailsViewController ()

@property (nonatomic,retain) Products *productSelected;
@property (weak, nonatomic) IBOutlet UITableView *productDetailstable;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@end

@implementation PSProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    [self initView];
    
    [self loadCachedDetails];
    
    if (_latestArrivalPromotion) {
        [self getProductDetailsForProductID:_latestArrivalPromotion.product_id andCategoryID:nil];
        _productName.text = _latestArrivalPromotion.name;

    }
    else {
        [self getProductDetailsForProductID:_selectedProduct.product_id andCategoryID:_selectedProduct.category_id];
        _productName.text = _selectedProduct.name;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self updateCartCount];
    
    _productDetailstable.rowHeight = UITableViewAutomaticDimension;
    _productDetailstable.estimatedRowHeight = 200.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

- (void)initView {
    
    UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    if (_isFromMenu) {
        UIBarButtonItem *rightBarItem = [[AppDelegate instance] getCartBarButtonItemWithTarget:self andSelector:@selector(cartAction:)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }
    else {
        NSArray *rightBarButtonItems = [[AppDelegate instance] getCartAndHomeButtonItemsWithTarget:self andCartSelector:@selector(cartAction:) andHomeSelector:@selector(homeAction:)];
        
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
}

- (void)loadCachedDetails{
    
    NSPredicate *predicate ;
    NSArray *results;
    if (!_selectedProduct) {
        
        predicate = [NSPredicate predicateWithFormat:@"product_id == %d",[_latestArrivalPromotion.product_id intValue]];
        results = [DatabaseHandler fetchItemsFromTable:TABLE_LATEST_ARRIVALS_PROMOTIONS
                                         withPredicate:predicate];
    }
    else{
        
      predicate = [NSPredicate predicateWithFormat:@"category_id == %d && product_id == %d", [_selectedProduct.category_id intValue],[_selectedProduct.product_id intValue]];

        results = [DatabaseHandler fetchItemsFromTable:TABLE_PRODUCTS
                                         withPredicate:predicate];
    }
    _productSelected = (Products*)[results lastObject];
    
    NSLog(@"Fetching over");
    
    if (_productSelected) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_productDetailstable reloadData];
        });
    }
    
    predicate = nil;
}

- (void)getProductDetailsForProductID:(NSNumber*)productID andCategoryID:(NSNumber*)categoryID{
    
    [[AppDelegate instance] showBusyView:@"Loading..."];
    
    [WebHandler getproductdetailsWithproductID:[productID intValue]
                                 andCategoryID:[categoryID intValue]
                                  andIsLatestArrrival:_latestArrivalPromotion
                                  withCallback:^(id object, NSError *error) {
          if (object != nil || error == nil) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [[AppDelegate instance] hideBusyView];
              });
              
              [self loadCachedDetails];
          }
          else {
              //Alert with the failure message.
          }
    }];
}

- (void)updateCartCount {
    
    NSArray *cartItems = [DatabaseHandler fetchItemsFromTable:TABLE_CART withPredicate:nil];
    
    int count = 0;
    
    for (Cart *cart in cartItems) {
        count = count + [cart.count intValue];
    }
    
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d", count];
}

#pragma mark - Button Actions

- (IBAction)cartAction:(id)sender {
    
    CartTableViewController * cartObj = (CartTableViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"CartTableViewController"];
    
    if (_isFromMenu) {
        cartObj.isFromMenuAndInnerView = YES;
    }
    
    [self.navigationController pushViewController:cartObj animated:YES];
}

- (IBAction)addToCartAction:(id)sender
{
    //[DatabaseHandler addToCartWithObj:self.selectedProduct];
    [DatabaseHandler addToCartWithObj:_productSelected];
    [self updateCartCount];
}

- (IBAction)wishlistAction:(id)sender {
   
    NSPredicate *predicate;
    LatestArrivals_Promotions *latestArrivals=nil;
    Products *products=nil;
    if ([_productSelected isKindOfClass:[Products class]]) {
        
        predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", _selectedProduct.category_id, _selectedProduct.product_id];
        products = (Products*)_productSelected;
    }
    else{
        
        predicate = [NSPredicate predicateWithFormat:@"product_id == %@",_productSelected.product_id];
        latestArrivals = (LatestArrivals_Promotions*)_productSelected;
    }
    
    NSArray *hasItem = [DatabaseHandler fetchItemsFromTable:@"WishList" withPredicate:predicate];
    
    if (![hasItem count]) {
        
        NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];

        
        WishList * wishObj = [NSEntityDescription insertNewObjectForEntityForName:@"WishList" inManagedObjectContext:moc];
        
        wishObj.category_id = products?products.category_id:0;
       // wishObj.price = products?products.category_id:latestArrivals.price;
        wishObj.product_id = products?products.product_id:latestArrivals.product_id;
        wishObj.model = products?products.model:latestArrivals.model;
        wishObj.name = products?products.name:latestArrivals.name;
        wishObj.thumb_image_url = products?products.thumb_image_url:latestArrivals.thumb_image_url;
        
       // [[DatabaseManager sharedInstance] saveContext];
        
        [moc performBlockAndWait:^{
            NSError *error = nil;
            
            if (![moc save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Wishlist");
            }
        }];
    }
    else {
        [DatabaseHandler deleteItemsFromTable:@"WishList" withPredicate:predicate];
    }
}

- (IBAction)homeAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:{
            
            ProductImageCell *imageCell = (ProductImageCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            [imageCell loadProductImage: _productSelected.relationship.image];
            cell = imageCell;
        }
        break;
        case 1:{
            
           PriceInfoCell *priceInfoCell = [tableView dequeueReusableCellWithIdentifier:@"priceInfoCell"];
            [priceInfoCell loadProductInformation:_productSelected];
             cell = priceInfoCell;
        }
        break;
        case 2:{
            
            ProductDescriptionCell *descriptionCell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            [descriptionCell loadProductDescription:_productSelected.relationship];
            cell = descriptionCell;
        }
            break;
            
        case 3:{
            
//            ProductSpecificationCell *specificationCell = [tableView dequeueReusableCellWithIdentifier:@"specificationCell"];
//            [specificationCell loadSpecifications:_productSelected];
//            cell = specificationCell;
             cell = [tableView dequeueReusableCellWithIdentifier:@"specificationLinkCell"];
             cell.textLabel.text = @"Specifications";
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Coredata notifications

/*
//Not using
- (void)managedObjectDidSaveProdDetails:(NSNotification *)notification {
    
    NSSet *insertObjects = [notification userInfo][@"inserted"];
    NSSet *updatedObjects = [notification userInfo][@"updated"];
    NSSet *deletedObjects = [notification userInfo][@"deleted"];
    id obj = [insertObjects anyObject];
    
    if ([[obj class] isSubclassOfClass:[Product_Details class]]||[[obj class] isSubclassOfClass:[Product_Attributes class]] ||[[obj class] isSubclassOfClass:[Products class]]) {
        
        [self loadCachedDetails];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate instance] hideBusyView];
            
        });
        NSLog(@"Did Save Sub Categories : \n%@", [obj class]);
    }
    
    insertObjects = nil;
    updatedObjects = nil;
    deletedObjects = nil;
    obj = nil;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[PSProductSpecificationsViewController class]]) {
        
        PSProductSpecificationsViewController *_productSpecVC = segue.destinationViewController;

        _productSpecVC.selectedProduct = _productSelected;
    }
}

@end
