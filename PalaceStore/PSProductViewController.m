//
//  PSProductViewController.m
//  PalaceStore
//
//  Created by Sreelash S on 02/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSProductViewController.h"
#import "CommonHeaders.h"
#import "ProductCollectionViewCell.h"
#import "WebHandler.h"
#import "DatabaseHandler.h"
#import "PSProductDetailsViewController.h"

@interface PSProductViewController ()
{
    NSArray * rawCollection;
}
@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (nonatomic, strong) NSArray *productsCollection;


@end

@implementation PSProductViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _categoryLabel.text = [NSString stringWithFormat:@"%@ (%d)", _productCategory.name, [_productCategory.product_count intValue]];
    
    [self setUpView];
    [self loadCachedProducts];
    [self getUpdatedProductListForCategory:_productCategory.category_id];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectDidSave:) name:NSManagedObjectContextDidSaveNotification object:[[DatabaseManager sharedInstance] managedObjectContext]];
}

- (void)getUpdatedProductListForCategory:(NSNumber*)categoryID{
    
    [WebHandler getProductListWithCategoryId:[categoryID intValue] withCallback:^(id object, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

- (void)setUpView {
    
    [HelperClass addBorderForView:_filterBgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    _filterBgView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];
    
    _firstRightBorderLabel.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
    _secondRightBorderLabel.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
    
    UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.title = @"Palace Store";
    
    [self sortBtnAction:_azBtn];
}

#pragma mark - Button Actions

- (void)navgationBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sortBtnAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
            _firstBottomBorder.hidden = NO;
            _secondBottomBorder.hidden = YES;
            _thirdBottomBorder.hidden = YES;
            
            if ([rawCollection count])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSSortDescriptor*  brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
                    _productsCollection = [rawCollection sortedArrayUsingDescriptors:[NSArray arrayWithObject:brandDescriptor]];
                    
                    [_productsCollectionView reloadData];
                });
            }

            
            break;
            
        case 2:
            _firstBottomBorder.hidden = YES;
            _secondBottomBorder.hidden = NO;
            _thirdBottomBorder.hidden = YES;
            
            NSLog(@"high to low");
            
            if ([rawCollection count])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"price"  ascending:NO];
                    _productsCollection = [rawCollection sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
                    
                    [_productsCollectionView reloadData];
                });
            }
            
            break;
            
        case 3:
            _firstBottomBorder.hidden = YES;
            _secondBottomBorder.hidden = YES;
            _thirdBottomBorder.hidden = NO;
            
            NSLog(@"low to high");
            if ([rawCollection count])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"price"  ascending:YES];
                    _productsCollection = [rawCollection sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
                    
                    [_productsCollectionView reloadData];
                });
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - COllection View Delegates & Data Sources

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return [_productsCollection count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @autoreleasepool {
        ProductCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"productCollectionViewCell" forIndexPath:indexPath];

        Products *product = _productsCollection[indexPath.row];
        [cell loadProductInformation:product];
       // cell.productInfo.text = product.name;
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
    
    CGFloat pixel = [UIScreen mainScreen].bounds.size.width/2;
    CGSize size;
    
//    if ([HelperClass is6thGeneration]) pixel = [UIScreen mainScreen].bounds.size.width/3;
//    else pixel = [UIScreen mainScreen].bounds.size.width/2;
    
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




- (void)loadCachedProducts {
    
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"category_id == %d", [_productCategory.category_id intValue]];
    NSLog(@"Fetching started");
    
   rawCollection = [DatabaseHandler fetchItemsFromTable:TABLE_PRODUCTS withPredicate:categoryPredicate];

    NSLog(@"Fetching over");
    if ([rawCollection count])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSSortDescriptor*  brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
            _productsCollection = [rawCollection sortedArrayUsingDescriptors:[NSArray arrayWithObject:brandDescriptor]];
            
            [_productsCollectionView reloadData];
        });
    }
    
    categoryPredicate = nil;
}

- (void)managedObjectDidSave:(NSNotification *)notification {
    
    NSSet *insertObjects = [notification userInfo][@"inserted"];
    NSSet *updatedObjects = [notification userInfo][@"updated"];
    NSSet *deletedObjects = [notification userInfo][@"deleted"];
    id obj = [insertObjects anyObject];
    
    if ([[obj class] isSubclassOfClass:[Products class]]) {
        [self loadCachedProducts];
        
        NSLog(@"Did Save Sub Categories : \n%@", [obj class]);
    }
    
    insertObjects = nil;
    updatedObjects = nil;
    deletedObjects = nil;
    obj = nil;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[PSProductDetailsViewController class]]) {
        
        PSProductDetailsViewController *_productDetailsVC = segue.destinationViewController;
        NSIndexPath *selectedIndex = [[_productsCollectionView indexPathsForSelectedItems] firstObject];
        _productDetailsVC.selectedProduct = _productsCollection[selectedIndex.row];
    }
}


@end
