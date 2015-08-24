//
//  CartTableViewController.m
//  PalaceStore
//
//  Created by Teja Swaroop on 21/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "CartTableViewController.h"

#import "Cart.h"


@interface CartTableViewController ()

@end

@implementation CartTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Cart";
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MenuIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.navigationItem.leftBarButtonItem = left;
}
-(IBAction)leftAction:(id)sender
{
     [self.sideMenuViewController presentLeftMenuViewController];

   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self fetchCartObjecsFrom];
}
-(void)fetchCartObjecsFrom
{
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Cart"];
    
   self.cartArray = [[[DatabaseManager sharedInstance]managedObjectContext] executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cartArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
   
    Cart * cartObj = [self.cartArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cartObj.name;
    
    [HelperClass loadImageWithURL:cartObj.thumb_image_url andCompletionBlock:^(UIImage *img, NSData *imgData) {
        cell.imageView.image = img;
        [cell.imageView reloadInputViews];
    }];
    return cell;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
