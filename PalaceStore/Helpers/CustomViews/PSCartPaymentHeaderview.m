//
//  PSCartPaymentHeaderview.m
//  PalaceStore
//
//  Created by Sreelash S on 21/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartPaymentHeaderview.h"
#import "UIColor+CustomColor.h"


@implementation PSCartPaymentHeaderview

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:1];
    
}

- (void)initHeaderViewForConfirmOrder:(PSCheckoutConfirmView *)confirmOrderView {
    
    _btn.hidden = YES;
    _btnEdit.hidden = NO;
    
    if (confirmOrderView) {
        [self.btnEdit addTarget:confirmOrderView action:@selector(orderViewEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Button Actions

- (void)addTargetToAddressListView {
    
    if (self.addressListView) {
        [self.btn addTarget:self.addressListView action:@selector(didSelectAddressOption:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addTargetToPaymentView {
    
    if (self.paymentView) {
        [self.btn addTarget:self.paymentView action:@selector(didSelectPaymentOption:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)aboutUsAction:(id)sender {
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(aboutTappedWithTag:)]) {
        [_delegate aboutTappedWithTag:_btnAboutUs.tag];
    }
}

@end
