//
//  PSAddressListView.m
//  PalaceStore
//
//  Created by Anamika on 9/24/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSAddressListView.h"
#import "PSAddressCell.h"

@interface PSAddressListView () {
    NSArray *addresses;
}

@end

@implementation PSAddressListView

#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return addresses.count;
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSAddressCell *cell = (PSAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"psAddresCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSAddressCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
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
