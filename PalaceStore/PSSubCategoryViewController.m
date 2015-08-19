//
//  PSCategoryViewController.m
//  PalaceStore
//
//  Created by Sreelash S on 29/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSSubCategoryViewController.h"
#import "PSProductViewController.h"

#import "HelperClass.h"
#import "WebHandler.h"
#import "DatabaseHandler.h"

@interface PSSubCategoryViewController ()

@property (nonatomic, strong) NSArray *subCategories;

@end

@implementation PSSubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.title = @"Palace Store";
    
    _categoryLabel.text = [NSString stringWithFormat:@"%@ (%d)", _productCategory.name, [_productCategory.subcategory_count intValue]];
    
    [self loadCachedSubCategories];
    
    [self getUpdatedSubCategoryForCategoryId:_productCategory.category_id];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectDidSave:) name:NSManagedObjectContextDidSaveNotification object:[[DatabaseManager sharedInstance] managedObjectContext]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)loadCachedSubCategories {
    
    NSPredicate *subCategoryPredicate = [NSPredicate predicateWithFormat:@"parent_category_id == %d", [_productCategory.category_id intValue]];
    NSLog(@"Fetching started");
    _subCategories = [DatabaseHandler fetchItemsFromTable:TABLE_PRODUCT_CATEGORY withPredicate:subCategoryPredicate];
    NSLog(@"Fetching over");
    if ([_subCategories count]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
    }
    
    subCategoryPredicate = nil;
}

- (void)getUpdatedSubCategoryForCategoryId:(NSNumber *)categoryId {
    
    [WebHandler getSubCategoriesForCategoryId:[categoryId intValue] withCallback:^(id object, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (void)navgationBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)categoryBtnClick:(Product_Category *)subCategory {
    
    int subCategoryCount = [subCategory.subcategory_count intValue];
    
    if (subCategoryCount > 0) {
        PSSubCategoryViewController *subCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
        subCategoryVC.productCategory = subCategory;
        [self.navigationController pushViewController:subCategoryVC animated:YES];
    }
    else {
        PSProductViewController *productVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductVC"];
        productVC.productCategory = subCategory;
        [self.navigationController pushViewController:productVC animated:YES];
    }
}

#pragma mark - COllection View Delegates & Data Sources

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return self.subCategories.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @autoreleasepool {
        SubCategoryCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SubCategoryCell" forIndexPath:indexPath];
        cell.callingControllerInstance = self;
        
        Product_Category *subCategory = self.subCategories[indexPath.row];
        
        [cell loadSubCategory:subCategory];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /*ProductCategory *selectedCategory = self.subCategories[indexPath.row];
    SFProductViewController *productVC = [self.storyboard instantiateViewControllerWithIdentifier:@"productViewController"];
    productVC.type = kViewCategoryProducts;
    productVC.category = selectedCategory;
    
    [self.navigationController pushViewController:productVC animated:YES];*/
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat pixel;
    CGSize size;
    
    if ([HelperClass is6thGeneration]) pixel = [UIScreen mainScreen].bounds.size.width/3;
    else pixel = [UIScreen mainScreen].bounds.size.width/2;
    
    size = CGSizeMake(pixel, pixel);
    
    return size;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);;
    
    return insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}

- (void)managedObjectDidSave:(NSNotification *)notification {
    
    NSSet *insertObjects = [notification userInfo][@"inserted"];
    NSSet *updatedObjects = [notification userInfo][@"updated"];
    NSSet *deletedObjects = [notification userInfo][@"deleted"];
    
    id obj = [insertObjects anyObject];
    
    /*NSLog(@"Inserted Obj : %@", insertObjects);
     //    NSLog(@"Updated Obj : %@", updatedObjects);
     //    NSLog(@"Deleted Obj : %@", deletedObjects);*/
    
    if ([[obj class] isSubclassOfClass:[Product_Category class]]) {
        [self loadCachedSubCategories];
        
        NSLog(@"Did Save Sub Categories : \n%@", [obj class]);
    }
    
    insertObjects = nil;
    updatedObjects = nil;
    deletedObjects = nil;
    obj = nil;
}

- (void)dealloc {
    
    _productCategory = nil;
    _subCategories   = nil;
}

@end
