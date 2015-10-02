//
//  PSAddressListView.m
//  PalaceStore
//
//  Created by Anamika on 9/24/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSAddressListView.h"
#import "PSAddressCell.h"
#import "DatabaseHandler.h"
#import "PSCartPaymentHeaderview.h"
#import "Address.h"
#import "WebHandler.h"

@interface PSAddressListView () {
    NSArray *addresses;
    NSInteger selecetedSectionIndex;
}

@end

@implementation PSAddressListView

- (void)awakeFromNib {
    
    addresses = [DatabaseHandler fetchItemsFromTable:TABLE_ADDRESS withPredicate:nil];
}

- (void)loadAddresses {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    addresses = [DatabaseHandler fetchItemsFromTable:TABLE_ADDRESS withPredicate:nil];
    
    if (addresses.count) {
        Address *address = [addresses objectAtIndex:selecetedSectionIndex];
        
        [userDefaults setValue:address.address_id forKey:KEY_USER_INFO_ADDRESS_ID];
        [userDefaults synchronize];
        
        [addressTableView reloadData];
    }
    else {
        NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
        
        [WebHandler getAllAddressWithUserId:userId withCallback:^(id object, NSError *error) {
            
        }];
    }
}

#pragma mark - Button Actions

- (IBAction)didSelectAddressOption:(id)sender {
    
    UIButton *_selected = (UIButton*)sender;
    
    selecetedSectionIndex = _selected.tag;
    
    Address *address = [addresses objectAtIndex:selecetedSectionIndex];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:address.address_id forKey:KEY_USER_INFO_ADDRESS_ID];
    [userDefaults synchronize];
    
    [addressTableView reloadData];
}

- (IBAction)addAddressAction:(id)sender {
    
    if (_addressListViewDelegate && ([_addressListViewDelegate respondsToSelector:@selector(addAddress)])) {
        
        [_addressListViewDelegate addAddress];
    }
}

- (IBAction)nextAction:(id)sender {
    
    if (_addressListViewDelegate && ([_addressListViewDelegate respondsToSelector:@selector(addressListViewNextAction)])) {
        
        [_addressListViewDelegate addressListViewNextAction];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return addresses.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 167;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    if (selecetedSectionIndex == section) {
        count = 1;
    }
    
    return count;
}

#pragma mark - Table View Delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PSCartPaymentHeaderview *paymentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentHeaderView" owner:self options:nil] lastObject];
    
    paymentHeaderView.addressListView = self;
    [paymentHeaderView addTargetToAddressListView];
    
    paymentHeaderView.txtLabel.text = [NSString stringWithFormat:@"Address %ld", section + 1];
    paymentHeaderView.btn.tag  = section;
    
    if (section == selecetedSectionIndex) {
        [paymentHeaderView.btn setSelected:YES];
    }
    else {
        [paymentHeaderView.btn setSelected:NO];
    }
    
    return paymentHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSAddressCell *cell = (PSAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"psAddresCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSAddressCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Address *address = [addresses objectAtIndex:indexPath.section];
    
    cell.lblFN.text = address.firstname;
    cell.lblLN.text = address.lastname;
    cell.txtAddress.text = address.address_1;
    cell.lblCity.text = address.city;
    cell.lblPostCode.text = address.postcode;
    
    return cell;
}

@end
