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
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,retain)NSMutableArray *deletionList;
@end

@implementation CartTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    [self setupView];
    _deleteBtn.hidden=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_isRerendering) 
        topConstraint.constant = 64;
    else if (_isFromMenu) {
        //self.automaticallyAdjustsScrollViewInsets = YES;
        topConstraint.constant = 200;
    }
    
    [self.view setNeedsUpdateConstraints];
    
    [self fetchCartObjecs];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _isRerendering = YES;
}

#pragma mark - Button Actions

- (IBAction)deleteMultipleCartItems:(UIButton *)sender {

    dispatch_queue_t deleteQueue = dispatch_queue_create("com.deleteQueue", NULL);

    for (NSNumber *index in _deletionList) {
        dispatch_sync(deleteQueue, ^{

            Cart * cartObj = [self.cartArray objectAtIndex:[index intValue]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", cartObj.category_id, cartObj.product_id];
            
            [DatabaseHandler deleteItemsFromTable:@"Cart" withPredicate:predicate];
            
            [self fetchCartObjecs];
            
            [cartTableView reloadData];
        });
    }
    
    [_deletionList removeAllObjects];
    
    (_deletionList.count>0)?(_deleteBtn.hidden=NO):(_deleteBtn.hidden=YES);
}

- (void)removeCartItemAtIndex:(NSInteger)index {
    
    Cart * cartObj = [self.cartArray objectAtIndex:index];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", cartObj.category_id, cartObj.product_id];
    
    [DatabaseHandler deleteItemsFromTable:@"Cart" withPredicate:predicate];
    
    [self fetchCartObjecs];
    
    [cartTableView reloadData];
}

- (void)updateDeleteCartList:(NSInteger)index {
    
    if (!_deletionList) {
        
        self.deletionList = [NSMutableArray array];
    }

    [_deletionList containsObject:[NSNumber numberWithInteger:index]]? [_deletionList removeObject:[NSNumber numberWithInteger:index]]:[_deletionList addObject:[NSNumber numberWithInteger:index]];

    (_deletionList.count>0)?(_deleteBtn.hidden=NO):(_deleteBtn.hidden=YES);
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
    cell.cartItemIndex = indexPath.row;
    cell.itemName.text = cartObj.name;
    cell.itemCost.text = priceStr;
    [cell loadProductImage:cartObj.thumb_image_url];
    
    //Check whether selected for deletion
    if (_deletionList && [_deletionList containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        
        [cell setSelectedForDeletion:YES];
    }
    else{
        
        [cell setSelectedForDeletion:NO];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 95;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
