//
//  PSCartPaymentview.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartPaymentView.h"


@interface PSCartPaymentView ()
@property (weak, nonatomic) IBOutlet UIButton *codBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankDepositBtn;
@property (weak, nonatomic) IBOutlet UIButton *mtnBtn;
@property (weak, nonatomic) IBOutlet UIButton *tigoBtn;
@property (weak, nonatomic) IBOutlet UIButton *airtelMoneyBtn;


@end

@implementation PSCartPaymentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)didSelectPaymentOption:(id)sender {
    
    [_codBtn setSelected:NO];
    [_bankDepositBtn setSelected:NO];
    [_mtnBtn setSelected:NO];
    [_tigoBtn setSelected:NO];
    [_airtelMoneyBtn setSelected:NO];

    UIButton *_selected = (UIButton*)sender;
    [_selected setSelected:YES];
}

@end
