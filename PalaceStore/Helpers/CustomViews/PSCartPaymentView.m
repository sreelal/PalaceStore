//
//  PSCartPaymentview.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartPaymentView.h"
#import "PSCartPaymentHeaderview.h"
#import "PSCartPaymentCell.h"

@interface PSCartPaymentView () {
    NSMutableArray *options;
    NSInteger selecetedSectionIndex;
    NSInteger lastSelectedIndex;
}

@property (weak, nonatomic) IBOutlet UIButton *codBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankDepositBtn;
@property (weak, nonatomic) IBOutlet UIButton *mtnBtn;
@property (weak, nonatomic) IBOutlet UIButton *tigoBtn;
@property (weak, nonatomic) IBOutlet UIButton *airtelMoneyBtn;

@end

@implementation PSCartPaymentView

- (void)awakeFromNib {
    
    options = [[NSMutableArray alloc] initWithObjects:@"Cash on Delivery", @"Bank Deposit / Transfer", @"Pay with MTN Mobile Money", @"Tigo Cash", @"Pay with Airtel Money", nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:options[selecetedSectionIndex] forKey:KEY_USER_INFO_PAYMENT_OPTION];
    [userDefaults synchronize];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Button Actions

- (IBAction)nextAction:(id)sender {
    
    if (_paymentViewDelegate && ([_paymentViewDelegate respondsToSelector:@selector(addressListViewNextAction)])) {
        
        [_paymentViewDelegate paymentNextAction];
    }
}

- (IBAction)didSelectPaymentOption:(id)sender {
    
    UIButton *_selected = (UIButton*)sender;
    
    selecetedSectionIndex = _selected.tag;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:options[selecetedSectionIndex] forKey:KEY_USER_INFO_PAYMENT_OPTION];
    [userDefaults synchronize];
    
    [payOptionsTableView reloadData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return options.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    if (section > 0 && selecetedSectionIndex == section) {
        count = 1;
        lastSelectedIndex = selecetedSectionIndex;
    }
    
//    if (lastSelectedIndex == selecetedSectionIndex) {
//        count = lastSelectedIndex = 0;
//    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

#pragma mark - Table View Delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PSCartPaymentHeaderview *paymentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentHeaderView" owner:self options:nil] lastObject];
    
    paymentHeaderView.paymentView = self;
    [paymentHeaderView addTargetToPaymentView];
    
    paymentHeaderView.txtLabel.text = options[section];
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
    
    PSCartPaymentCell *cell = (PSCartPaymentCell*)[tableView dequeueReusableCellWithIdentifier:@"paymentOptionCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentCell" owner:self options:nil];
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
