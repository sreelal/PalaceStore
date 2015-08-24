//
//  ProfileViewController.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProfileViewController.h"

#import "ProfileCell.h"

#import "MyCartCell.h"

#import "CartTableViewController.h"

#import "WhishListViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title =@"Palace";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString * simpleTableIdentifier = @"ProfielCell";
        
        ProfileCell * cell = (ProfileCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        static NSString * simpleTableIdentifier = @"MyCartCell";
        
        MyCartCell * cell = (MyCartCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCartCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        return cell;
    }
    else
    {
        static NSString * simpleTableIdentifier = @"MywhishListCell";
        
        MyCartCell * cell = (MyCartCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCartCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    [headerView  setBackgroundColor:[UIColor redColor]];
    
    UILabel * cartLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
    cartLabel.textAlignment = NSTextAlignmentLeft;
    cartLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:cartLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTintColor:[UIColor whiteColor]];
    button.tag = section;
    [button setTitle:@"More >" forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 35);
    [headerView addSubview:button];
    
    if (section == 1)
    {
     cartLabel.text =@"My Cart";
    }
    if (section == 2)
    {
        cartLabel.text =@"My Whish list";
    }

    
    return headerView;
}
-(IBAction)moreAction:(id)sender
{
    NSLog(@"%s",__func__);
    
    UIButton * btn = (UIButton*)sender;
    
    NSLog(@"btn tag %ld",(long)btn.tag);
    
    switch (btn.tag)
    {
        case 1:
        {
            CartTableViewController * cartObj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"CartTableViewController"];
            [self.navigationController pushViewController:cartObj animated:YES];
        }
            break;
        case 2:
        {
            WhishListViewController * whishObj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"WhishListViewController"];
            [self.navigationController pushViewController:whishObj animated:YES];

        }
            break;

        default:
            break;
    }
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
