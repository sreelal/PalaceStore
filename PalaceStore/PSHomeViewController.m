//
//  PSHomeViewController.m
//  PalaceStore
//
//  Created by Sreelal  Hamsavahanan on 02/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSSubCategoryViewController.h"
#import "PSProductViewController.h"

#import "BannerTableViewCell.h"
#import "LatestArrivalPromotionTableViewCell.h"
#import "CategoryTableViewCell.h"

#import "WebHandler.h"
#import "Banner.h"
#import "Constants.h"

#import "ProfileViewController.h"


@class DatabaseHandler;
@interface PSHomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *bannerContainerView;

@property (strong, nonatomic) NSArray *latestArrivals;
@property (strong, nonatomic) NSArray *promotions;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableArray *bannerCollection;

@property (weak, nonatomic) IBOutlet UITableView *homeCollectionTable;

@end

@implementation PSHomeViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
   
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(ProfileView:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.title = @"Palace";
    
    _bannerCollection = [[NSMutableArray alloc] init];
    
    [self loadLatestArrivalsAndPromotions];
    [self loadBannerImages];
    [self loadCategories];
    
    [self loadHomeData];
}
-(IBAction)ProfileView:(id)sender
{
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectDidSave:) name:NSManagedObjectContextDidSaveNotification object:[[DatabaseManager sharedInstance] managedObjectContext]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)loadBannerImages {
    
    NSArray *bannerimages = [DatabaseHandler fetchItemsFromTable:TABLE_BANNER_IMAGES withPredicate:nil];
    
    if ([bannerimages count]) {
        [_bannerCollection removeAllObjects];
        
        [bannerimages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Banner_Images *bannerImage = obj;
            NSString *imgURL = bannerImage.image_url;
            
            if (imgURL) [_bannerCollection addObject:imgURL];
        }];
        
        if ([_bannerCollection count]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_homeCollectionTable reloadData];
            });
        }
    }
}

- (void)loadLatestArrivalsAndPromotions {
    
    NSPredicate *latestPredicate = [NSPredicate predicateWithFormat:@"is_latest == 1"];
    NSPredicate *promotionPredicate = [NSPredicate predicateWithFormat:@"is_promotion == 1"];
    
    _latestArrivals = [DatabaseHandler fetchItemsFromTable:TABLE_LATEST_ARRIVALS_PROMOTIONS withPredicate:latestPredicate];
    _promotions = [DatabaseHandler fetchItemsFromTable:TABLE_LATEST_ARRIVALS_PROMOTIONS withPredicate:promotionPredicate];
    
    if ([_latestArrivals count] || [_promotions count]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_homeCollectionTable reloadData];
        });
    }
}

- (void)loadCategories {
    
    _categories = [DatabaseHandler fetchItemsFromTable:TABLE_PRODUCT_CATEGORY withPredicate:nil];
    
    if ([_categories count]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_homeCollectionTable reloadData];
        });
    }
}

- (void)loadHomeData {
    
    [WebHandler getHomeDetailsWithCallback:^(id object, NSError *error) {
        if (object == nil) {
            //To Do:- Show Alert
        }
    }];
}

#pragma mark - Button Actions

- (void)categoryBtnClick:(Product_Category *)category {
        
    int subCategoryCount = [category.subcategory_count intValue];
    
    if (subCategoryCount > 0) {
        PSSubCategoryViewController *subCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
        subCategoryVC.productCategory = category;
        [self.navigationController pushViewController:subCategoryVC animated:YES];
    }
    else {
        PSProductViewController *productVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductVC"];
        productVC.productCategory = category;
        [self.navigationController pushViewController:productVC animated:YES];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    NSInteger rowCount = 3;
    
//    if ([_bannerCollection count] <= 0) {
//        rowCount = 0;
//    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0: {
            BannerTableViewCell *bannerCell = (BannerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"bannerCell" forIndexPath:indexPath];
            
            [bannerCell loadBannerImagesWith:self.bannerCollection];
            
            if ([_latestArrivals count]) {
                [bannerCell loadLatestArrival:[_latestArrivals firstObject]];
            }
            
            if ([_promotions count]) {
                [bannerCell loadPromotion:[_promotions firstObject]];
            }
            
            cell = bannerCell;
        }
        break;
        
        case 1: {
            LatestArrivalPromotionTableViewCell *latestAndpromotionCell = (LatestArrivalPromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LatestArrivalPromotionCell" forIndexPath:indexPath];
            
            if ([_latestArrivals count] || [_promotions count]) {
                latestAndpromotionCell.latestArrivals = _latestArrivals;
                latestAndpromotionCell.promotionalItems = _promotions;
                
                [latestAndpromotionCell loadLatestArrivals:nil];
            }
            
            cell = latestAndpromotionCell;
        }
        break;
        
        case 2: {
            CategoryTableViewCell *categoryCell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
            categoryCell.callingControllerInstance = self;
            
            if ([_categories count]) {
                categoryCell.categories = _categories;
                [categoryCell loadCategories];
            }
            
            NSMutableArray *marqueeImages= [[NSMutableArray alloc] init];
            
            for (int iIndex = 1; iIndex<=11; iIndex++) {
                [marqueeImages addObject:[NSString stringWithFormat:@"%d.png",iIndex]];
            }
            
            [categoryCell performSelector:@selector(loadMarqueeControlWith:) withObject:marqueeImages afterDelay:0.1];
            
            cell = categoryCell;
        }
        break;
            
        default:
        break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height;
    
    if (indexPath.row == 0)
        height = 300.0f;
    else if (indexPath.row == 1)
        height = 156.0f;
    else
        height = 220.0f;
    
    return height;
}

#pragma mark - Core Data Notification

- (void)managedObjectDidSave:(NSNotification *)notification {
    
    NSSet *insertObjects = [notification userInfo][@"inserted"];
    NSSet *updatedObjects = [notification userInfo][@"updated"];
    NSSet *deletedObjects = [notification userInfo][@"deleted"];
    
    id obj = [insertObjects anyObject];
    
    /*NSLog(@"Inserted Obj : %@", insertObjects);
//    NSLog(@"Updated Obj : %@", updatedObjects);
//    NSLog(@"Deleted Obj : %@", deletedObjects);*/
    
    if ([[obj class] isSubclassOfClass:[Banner_Images class]]) {
        NSLog(@"Did Save Banner Images : \n%@", [obj class]);
    }
    else if ([[obj class] isSubclassOfClass:[LatestArrivals_Promotions class]]) {
        NSLog(@"Did Save Latest Arrivals : \n%@", [obj class]);
    }
    else if ([[obj class] isSubclassOfClass:[Product_Category class]]) {
        [self loadBannerImages];
        [self loadLatestArrivalsAndPromotions];
        [self loadCategories];
        
        NSLog(@"Did Save Product Categories : \n%@", [obj class]);
    }
}

@end
