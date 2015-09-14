//
//  WhishListViewController.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "WhishListViewController.h"

#import "WishList.h"

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
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    WishList * wishObj = [self.whishListArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = wishObj.name;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
