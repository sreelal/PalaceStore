//
//  PSCheckoutConfirmView.m
//  PalaceStore
//
//  Created by Sreelash S on 28/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCheckoutConfirmView.h"
#import "PSCartPaymentHeaderview.h"
#import "DatabaseHandler.h"
#import "PSAddressCell.h"
#import "Cart.h"
#import "Address.h"
#import "AppDelegate.h"

@interface PSCheckoutConfirmView () {
    NSArray *sections;
    NSArray *carts;
    NSArray *addresses;
    int totalPrice;
}

@end

@implementation PSCheckoutConfirmView

- (void)awakeFromNib {
    
}

- (void)initView {
    sections = [NSArray arrayWithObjects:@"Ordered Items", @"Sub Total", @"Delivery Address", @"Pay Mode", nil];
    
    carts = [DatabaseHandler fetchItemsFromTable:TABLE_CART withPredicate:nil];
    
    for (Cart *cart in carts) {
        totalPrice = totalPrice + ([cart.price intValue] * [cart.count intValue]);
    }
    
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    NSString *selectedAddressId = [userDefauls valueForKey:KEY_USER_INFO_ADDRESS_ID];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"address_id == %@", selectedAddressId];
    
    addresses = [DatabaseHandler fetchItemsFromTable:TABLE_ADDRESS withPredicate:predicate];
}

#pragma mark - Private Actions

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Palace Stores" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark - Button Actions

- (IBAction)orderViewEditAction:(id)sender {
    
}

- (IBAction)confirmOrderAction:(id)sender {
    [[AppDelegate instance] showBusyView:@"Confirming Order..."];
    
    [self performSelector:@selector(hideBusyView) withObject:nil afterDelay:8];
}

- (void)hideBusyView {
    
    [[AppDelegate instance] hideBusyView];
    
    [self showAlertWithMessage:@"Thank you for shopping with Palace Stores."];
    
    if (_confirmViewDelegate && ([_confirmViewDelegate respondsToSelector:@selector(didSuccessCheckout)])) {
        
        [_confirmViewDelegate didSuccessCheckout];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger height;
    
    switch (indexPath.section) {
        case 0:
            height = 60;
            break;
            
        case 2:
            height = 167;
            break;
            
        default:
            break;
    }
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    switch (section) {
        case 0:
            count = carts.count;
            break;
            
        case 2:
            count = addresses.count;
            break;
            
        default:
            break;
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

#pragma mark - Table View Delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PSCartPaymentHeaderview *paymentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentHeaderView" owner:self options:nil] lastObject];
    
    [paymentHeaderView initHeaderViewForConfirmOrder:self];
    
    paymentHeaderView.txtLabel.text = sections[section];
    paymentHeaderView.btnEdit.tag  = section;
    
    paymentHeaderView.btnEdit.hidden = YES;
    
    switch (section) {
        case 1:{
            NSString *totalPriceStr = [NSString stringWithFormat:@"%@ : GHS %d", sections[section], totalPrice];
            paymentHeaderView.txtLabel.text = totalPriceStr;
        }
        break;
            
        case 3:{
            NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
            NSString *selectedMode = [userDefauls valueForKey:KEY_USER_INFO_PAYMENT_OPTION];
            selectedMode = [NSString stringWithFormat:@"%@ : %@", sections[section], selectedMode];
            paymentHeaderView.txtLabel.text = selectedMode;
        }
            break;
            
        default:
            break;
    }
    
    return paymentHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:{
            MyCartCell *cartCell = (MyCartCell*)[tableView dequeueReusableCellWithIdentifier:@"MyCartCell"];
            
            if (cartCell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCartCell" owner:self options:nil];
                cartCell = [nib objectAtIndex:0];
            }
            
            cartCell.btnDelete.hidden = YES;
            
            Cart * cartObj = [carts objectAtIndex:indexPath.row];
            int price = [cartObj.price intValue] * [cartObj.count intValue];
            NSString *priceStr = [NSString stringWithFormat:@"GHS %@ x %@ = GHS %d", cartObj.price, cartObj.count, price];
            
            cartCell.itemName.text = cartObj.name;
            cartCell.itemCost.text = priceStr;
            
            [cartCell loadProductImage:cartObj.thumb_image_url];
            
            cell = cartCell;
        }
        break;
            
        case 2: {
            PSAddressCell *addressCell = (PSAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"psAddresCell"];
            
            if (addressCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSAddressCell" owner:self options:nil];
                addressCell = [nib objectAtIndex:0];
            }
            
            Address *address = [addresses objectAtIndex:indexPath.row];
            
            addressCell.lblFN.text = address.firstname;
            addressCell.lblLN.text = address.lastname;
            addressCell.txtAddress.text = address.address_1;
            addressCell.lblCity.text = address.city;
            addressCell.lblPostCode.text = address.postcode;
            
            cell = addressCell;
        }
        break;
            
        default:
        break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*static NSString *simpleTableIdentifier = @"SimpleTableItem";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.textLabel.text = @"Test";*/
    
    return cell;
}

@end
