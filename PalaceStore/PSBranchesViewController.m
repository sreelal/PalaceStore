//
//  PSLocationViewController.m
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/17/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSBranchesViewController.h"
#import "AppDelegate.h"
#import "WebHandler.h"
#import "PSBranchesTableViewCell.h"
#import "PSBranchDetialsViewController.h"

@interface PSBranchesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *branchesTable;
@property (retain, nonatomic) NSDictionary *branchesData;

@end

@implementation PSBranchesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadBranches];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)loadBranches {
    
    [[AppDelegate instance] showBusyView:@"Loading..."];

    [WebHandler getBranchesWithCallback:^(id object, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (object != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _branchesData = object;
                    [_branchesTable reloadData];
                });
            }
            else {
                [HelperClass showAlertWithMessage:@"Failed to get Branches!"];
            }
            
            [[AppDelegate instance] hideBusyView];
        });
    }];
}

- (void)setupView {
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
    
    _branchesTable.rowHeight = UITableViewAutomaticDimension;
    _branchesTable.estimatedRowHeight = 108.0;
}

#pragma mark - Table View Data Source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *_arr = (NSArray*)_branchesData[@"stores"];
    return [_arr count];
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"branchesCell";
    
    PSBranchesTableViewCell *cell = (PSBranchesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *_branchDetails = [(NSArray*)_branchesData[@"stores"] objectAtIndex:indexPath.row];

    cell.addressLabel.text = _branchDetails[@"address"]?_branchDetails[@"address"]:@"";
    cell.emailLabel.text = _branchDetails[@"email"]?_branchDetails[@"email"]:@"";
    cell.telephoneLabel.text = _branchDetails[@"telephone"]?_branchDetails[@"telephone"]:@"";
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[PSBranchDetialsViewController class]]) {
        
        
        PSBranchDetialsViewController *_productDetailsVC = segue.destinationViewController;
        NSIndexPath *selectedIndex = [_branchesTable indexPathForSelectedRow];
        NSDictionary *_branchDetails = [(NSArray*)_branchesData[@"stores"] objectAtIndex:selectedIndex.row];
        _productDetailsVC.branchData = _branchDetails;//_branchDetails[@"geocode"]?_branchDetails[@"geocode"]:@"";
    }

}

#pragma mark - Button Actions

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
