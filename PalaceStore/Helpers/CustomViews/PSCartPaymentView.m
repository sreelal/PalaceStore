//
//  PSCartPaymentview.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartPaymentView.h"
#import "PSCartPaymentHeaderview.h"

@interface PSCartPaymentView () {
    NSMutableArray *options;
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)didSelectPaymentOption:(id)sender {
    
//    [_codBtn setSelected:NO];
//    [_bankDepositBtn setSelected:NO];
//    [_mtnBtn setSelected:NO];
//    [_tigoBtn setSelected:NO];
//    [_airtelMoneyBtn setSelected:NO];
//
    UIButton *_selected = (UIButton*)sender;
    [_selected setSelected:YES];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return options.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

#pragma mark - Table View Delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PSCartPaymentHeaderview *paymentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentHeaderView" owner:self options:nil] lastObject];
    
    paymentHeaderView.txtLabel.text = options[section];
    paymentHeaderView.btn.tag  = section;
    
    return paymentHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = @"Test";
    return cell;
}

@end
