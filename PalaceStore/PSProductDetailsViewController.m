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
#import "ProductDescriptionCell.h"
#import "ProductSpecificationCell.h"
#import "PSProductSpecificationsViewController.h"

@interface PSProductDetailsViewController ()

@property (nonatomic,retain) Products *productSelected;
@property (weak, nonatomic) IBOutlet UITableView *productDetailstable;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@end

@implementation PSProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadCachedDetails];
    [self getProductDetailsForProductID:_selectedProduct.product_id andCategoryID:_selectedProduct.category_id];
    
    _productName.text = _selectedProduct.name;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:[[DatabaseManager sharedInstance] managedObjectContext]];
    
    _productDetailstable.rowHeight = UITableViewAutomaticDimension;
    _productDetailstable.estimatedRowHeight = 200.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCachedDetails{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %d && product_id == %d", [_selectedProduct.category_id intValue],[_selectedProduct.product_id intValue]];
    NSLog(@"Fetching started");
    NSArray *results = [DatabaseHandler fetchItemsFromTable:TABLE_PRODUCTS
                                                 withPredicate:predicate];
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
    
    [WebHandler getproductdetailsWithproductID:[productID intValue]
                                 andCategoryID:[categoryID intValue]
                                  withCallback:^(id object, NSError *error) {
        
    }];
}


#pragma mark -  Tableview delegates

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 4;
//}


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

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row==2) {
//        
//        return 100;
//    }
//    return UITableViewAutomaticDimension;
//}


#pragma mark - Coredata notifications


- (void)managedObjectDidSave:(NSNotification *)notification {
    
    NSSet *insertObjects = [notification userInfo][@"inserted"];
    NSSet *updatedObjects = [notification userInfo][@"updated"];
    NSSet *deletedObjects = [notification userInfo][@"deleted"];
    id obj = [insertObjects anyObject];
    
    if ([[obj class] isSubclassOfClass:[Product_Details class]]||[[obj class] isSubclassOfClass:[Product_Attributes class]]) {
        [self loadCachedDetails];
        NSLog(@"Did Save Sub Categories : \n%@", [obj class]);
    }
    
    insertObjects = nil;
    updatedObjects = nil;
    deletedObjects = nil;
    obj = nil;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[PSProductSpecificationsViewController class]]) {
        
        PSProductSpecificationsViewController *_productSpecVC = segue.destinationViewController;

        _productSpecVC.selectedProduct = _productSelected;
    }
}



@end
