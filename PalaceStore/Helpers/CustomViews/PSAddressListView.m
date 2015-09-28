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
    
    addresses = [DatabaseHandler fetchItemsFromTable:TABLE_ADDRESS withPredicate:nil];
    [addressTableView reloadData];
}

#pragma mark - Button Actions

- (IBAction)didSelectPaymentOption:(id)sender {
    
    UIButton *_selected = (UIButton*)sender;
    
    selecetedSectionIndex = _selected.tag;
    
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
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSAddressCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
}

@end
